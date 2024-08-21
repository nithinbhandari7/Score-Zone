//
//  ContentView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    NavigationLink(destination: ViewGamesView()) {
                        Text("View Games")
                            .padding(10)
                            .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            .cornerRadius(10)
                            .scaleEffect(1.3)
                    }
                    
                    Spacer()
                        .frame(height: 150.0)
                    
                    NavigationLink(destination: PlayerNamesView()) {
                        Text("Start New Game")
                            .padding(10)
                            .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            .cornerRadius(10)
                            .scaleEffect(1.3)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
