//
//  StartGameView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/2/24.
//

import SwiftUI

struct StartGameView: View {
    
    @State var playerNames: [String]
    
    var body: some View {
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                    .frame(height: 50.0)
                
                Text("Select Gamemode")
                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                    .scaleEffect(1.4)
                
                Spacer()
                
                NavigationLink(destination: EliminationNumberView(playerNames: playerNames)) {
                    Text("Elimination")
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.3)
                }
                
                Spacer()
                    .frame(height: 75.0)
                
                NavigationLink(destination: TargetNumberView(playerNames: playerNames)) {
                    Text("Target")
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.3)
                }
                
                Spacer()
                    .frame(height: 75.0)
                
                NavigationLink(destination: ScoreNumberView(playerNames: playerNames)) {
                    Text("Score")
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
}

#Preview {
    StartGameView(playerNames: ["A"])
}
