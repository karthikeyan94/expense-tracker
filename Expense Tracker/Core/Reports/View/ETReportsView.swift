//
//  ETReportsView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 15/09/23.
//

import SwiftUI
import SwiftData
import OSLog
import FirebaseStorage

struct ETReportsView: View {
    
    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "ETReportsView")
    
    @State private var reportLayout: ETReportLayout = .yearly
    
    @State private var showExportSheet = false
    
    @State private var exportingDocument = ETTransactionDocument("")
    
    @State private var didFirebaseUploadSuccess = false
    
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: [SortDescriptor<ETMonthCashFlow>(\.date, order: .reverse)])
    var months: [ETMonthCashFlow]
    
    var previousMonths: [ETMonthCashFlow] {
        let currentMonth = Date.now.formatExpenseMonth()
        return months.filter{ $0.id != currentMonth }
    }
    
    var yearlySummary: [ETYearWiseSummary] {
        let groupedYears = Dictionary(grouping: months) { monthCashflow in
            Calendar.current.component(.year, from: monthCashflow.date)
        }
        
        return groupedYears.map { year, cashflows in
            let totalIncome = cashflows.reduce(0.0) { $0 + $1.income }
            let totalExpenses = cashflows.reduce(0.0) { $0 + $1.expenses }
            return ETYearWiseSummary(year: year, income: totalIncome, expenses: totalExpenses)
        }
        .sorted(by: { $0.year < $1.year })
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Layout", selection: $reportLayout) {
                    ForEach(ETReportLayout.allCases) { layout in
                        Text(layout.rawValue.capitalized)
                    }
                }
                .pickerStyle(.segmented)
                
                if reportLayout == .monthly {
                    if previousMonths.isEmpty {
                        ETReportsEmptyView()
                    } else {
                        List(previousMonths) { month in
                            NavigationLink(value: month) {
                                Text(month.id)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                        }
                        .listStyle(.plain)
                        .navigationDestination(for: ETMonthCashFlow.self) { month in
                            ETReportsMonthRouterView(month: month)
                                .navigationTitle(month.id)
                        }
                    }
                } else {
                    ScrollView {
                        if yearlySummary.isEmpty {
                            ETReportsEmptyView()
                        } else {
                            ETYearWiseSummaryView(yearlySummary: yearlySummary)
                            ETYearlySummaryChart()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Reports")
            .toolbar {
                ToolbarItem {
                    Button(action: exportTransactions) {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.original)
                    }
                }
                ToolbarItem {
                    Button(action: uploadToFirebaseStorage) {
                        Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                            .renderingMode(.original)
                    }
                }
            }
            .fileExporter(isPresented: $showExportSheet, document: exportingDocument, contentType: .text, defaultFilename: "Expense Tracker Transactions.json") { result in
                switch result {
                case .success(_):
                    ETReportsView.logger.info("Transactions exported successfully")
                case .failure(let error):
                    ETReportsView.logger.warning("\(error.localizedDescription)")
                }
            }
            .alert(Text("Success"), isPresented: $didFirebaseUploadSuccess) {
                Button("OK") {
                }
            } message: {
                Text("Transactions data uploaded.")
            }
        }
    }
    
    func exportTransactions() -> Void {
        ETReportsView.logger.info("Export transactions initiated")
        guard let document = self.generateTransactionsExportableDocument() else {
            return
        }
        exportingDocument = document
        showExportSheet = true
    }
    
    func generateTransactionsExportableDocument() -> ETTransactionDocument? {
        do {
            ETReportsView.logger.info("Generating exportable transactions document")
            var document:ETTransactionDocument = ETTransactionDocument("")
            document.text += "{"
            for month in months {
                if month != months.first {
                    document.text += ","
                }
                document.text += "\"\(month.id)\":{\"summary\":"
                let monthJson = try JSONEncoder().encode(month)
                if let monthString = String(data: monthJson, encoding: .utf8) {
                    document.text += "\(monthString)"
                } else {
                    document.text += "{}"
                }
                
                let (startOfMonth, endOfMonth) = month.date.startAndEndOfMonth()
                let predicate = #Predicate<ETTransaction> { $0.date >= startOfMonth && $0.date <= endOfMonth}
                let transactions = try modelContext.fetch(FetchDescriptor<ETTransaction>(predicate: predicate, sortBy: [SortDescriptor(\.date, order: .forward)]))
                let transactionsJson = try JSONEncoder().encode(transactions)
                document.text += ",\"transactions\":"
                if let transactionsString = String(data: transactionsJson, encoding: .utf8) {
                    document.text += "\(transactionsString)"
                } else {
                    document.text += "[]"
                }
                document.text += "}"
            }
            document.text += "}"
            return document
        } catch {
            ETReportsView.logger.warning("Export document generation failed due to \(error.localizedDescription)")
            return nil
        }
    }
    
    func uploadToFirebaseStorage() -> Void {
        guard let document = self.generateTransactionsExportableDocument() else {
            return
        }
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let backupFileRef = storageRef.child("backups/Expense Tracker Transactions.json")
        
        let fileMetadata = StorageMetadata()
        fileMetadata.contentType = "application/json"
        
        backupFileRef.putData(Data(document.text.utf8), metadata: fileMetadata) { metadata, error in
            guard metadata != nil else {
                ETReportsView.logger.warning("File could not be uploaded.")
                return
            }
            if let errorUnwraped = error {
                ETReportsView.logger.warning("Firebase storage upload failed due to \(errorUnwraped.localizedDescription)")
                return
            }
            ETReportsView.logger.info("Expese Tracker transactions uploaded to firebase storage.")
            didFirebaseUploadSuccess = true
        }
    }
}

struct ETReportsEmptyView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4){
            Spacer()
            Image(systemName: "questionmark.circle")
                .renderingMode(.original)
                .font(.system(size: 40))
            Text("No Data")
            Spacer()
        }
    }
}

struct ETReportsMonthRouterView: View {
    var month: ETMonthCashFlow
    
    var monthTransactionQuery: Query<ETTransaction, [ETTransaction]> {
        let (startOfMonth, endOfMonth) = month.date.startAndEndOfMonth()
        let predicate = #Predicate<ETTransaction> { $0.date >= startOfMonth && $0.date <= endOfMonth}
        return Query(filter: predicate, sort: \.date, order: .reverse)
    }
    
    var body: some View {
        ETMonthView(monthCashflow: month, _transactions: monthTransactionQuery)
    }
}

#Preview {
    ETReportsView()
        .modelContainer(previewContainer)
}
