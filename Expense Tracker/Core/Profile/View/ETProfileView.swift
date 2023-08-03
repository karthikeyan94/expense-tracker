//
//  ProfileView.swift
//  Expense Tracker
//
//  Created by Sivabalan M on 21/07/23.
//

import SwiftUI

struct ETProfileView: View {
    var body: some View {
        VStack {
            
            VStack {
                Image("profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .clipShape(Circle())
                
                HStack {
                    Text("Sivabalan")
                    Text("Murugavel")
                }
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                
                Divider()
            }
            .frame(maxWidth: .infinity)
            .background(
                Color(.systemBlue)
                    .opacity(0.8)
            )
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button {
                        
                    } label: {
                        Label("Edit profile", systemImage: "pencil")
                    }
                    Spacer()
                }
                Divider()
                HStack {
                    Button {
                        
                    } label: {
                        Label("Change password", systemImage: "lock.fill")
                    }
                    Spacer()
                }
                Divider()
            }
            .padding()
            .foregroundColor(.blue)
            .font(.title3)
            
            Button(role: .destructive) {
                
            } label: {
                Text("Sign out")
            }
            .buttonStyle(.bordered)
            .tint(.red)
            .padding(.vertical)
            
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ETProfileView()
    }
}
