//
//  TargetNumberView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/4/24.
//

import SwiftUI

struct TargetNumberView: View {
    
    @State var playerNames: [String]
    @State var targetNumber: Int = 0
    
    var body: some View {
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Text("Select score needed to win")
                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                    .scaleEffect(1.15)
                
                Picker(
                    selection: $targetNumber,
                    label: Text("Picker"),
                    content: {
                        ForEach(1..<1000) { number in
                            Text("\(number)")
                                .tag("\(number)")
                        }
                    }
                )
                .pickerStyle(WheelPickerStyle())
                
                NavigationLink(destination: TargetTableView(playerNames: playerNames, targetNumber: targetNumber)) {
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
    TargetNumberView(playerNames: ["A"])
}
