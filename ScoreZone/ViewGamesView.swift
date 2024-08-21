//
//  ViewGamesView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/15/24.
//

import SwiftUI

struct ViewGamesView: View {
    var body: some View {
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                ZStack {
                    Text("\nPlayers compete to avoid reaching a specified elimination score. Once a player hits this score, they are eliminated. The game continues until only one player remains.")
                        .frame(width: 250.0, height: 165.0)
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                    
                    Text("Elimination")
                        .padding(.bottom, 145)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                        .bold()
                }
                
                Spacer()
                
                ZStack {
                    Text("\nThe objective is to be the first player to reach a predetermined target score. The first player to achieve this target wins the game.")
                        .frame(width: 250.0, height: 155.0)
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                    
                    Text("Target")
                        .padding(.bottom, 135)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                        .bold()
                }
                
                Spacer()
                
                ZStack {
                    Text("\nPlayers accumulate points over a set number of rounds. The player with the highest total score at the end of these rounds wins the game.")
                        .frame(width: 250.0, height: 155.0)
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                    
                    Text("Score")
                        .padding(.bottom, 135)
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.2)
                        .bold()
                }
                
                Spacer()
                    .frame(height: 25.0)
            }
        }
    }
}

#Preview {
    ViewGamesView()
}
