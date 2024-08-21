//
//  ScoreNumberView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/4/24.
//

import SwiftUI

struct ScoreNumberView: View {
    
    @State var playerNames: [String]
    @State var roundNumber: Int = 0
    
    var body: some View {
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Text("Select number of rounds")
                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                    .scaleEffect(1.15)
                
                Picker(
                    selection: $roundNumber,
                    label: Text("Picker"),
                    content: {
                        ForEach(1..<1000) { number in
                            Text("\(number)")
                                .tag("\(number)")
                        }
                    }
                )
                .pickerStyle(WheelPickerStyle())
                
                NavigationLink(destination: ScoreTableView(playerNames: playerNames, maxRounds: roundNumber)) {
                    Text("Start")
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.3)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ScoreNumberView(playerNames: ["A"])
}
