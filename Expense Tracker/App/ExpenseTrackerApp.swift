//
//  ExpenseTrackerApp.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 21/07/23.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct ExpenseTrackerApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            ETRootContentView()
        }
        .modelContainer(for: [
            ETTransaction.self,
            ETMonthCashFlow.self
        ])
    }
}
