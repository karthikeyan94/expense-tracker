//
//  MainTabView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 21/07/23.
//

import SwiftUI

struct ETMainTabView: View {
    
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ETHomeView()
                .onAppear {
                    selectedTab = 0
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            ETReportsView()
                .onAppear {
                    selectedTab = 1
                }
                .tabItem {
                    Label("Reports", systemImage: "chart.bar.fill")
                }
                .tag(1)
        }
    }
}

#Preview {
    ETMainTabView()
        .modelContainer(previewContainer)
}
