//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 21/07/23.
//

import SwiftUI

struct ETRootContentView: View {
    var body: some View {
        ETMainTabView()
    }
}

#Preview {
    ETRootContentView()
        .modelContainer(previewContainer)
}
