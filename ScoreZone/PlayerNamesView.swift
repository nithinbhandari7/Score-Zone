//
//  PlayerNamesView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/4/24.
//

import SwiftUI

struct PlayerNamesView: View {
    
    @State var playerNames: [String] = ["", ""]
    @State var validNames: Bool = false;

    var body: some View {
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Text("Enter player names")
                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                    .scaleEffect(1.25)
                
                List {
                    HStack{
                        Text("1")
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        
                        Spacer()
                            .frame(width: 20.0)
                        
                        TextField("Enter name here", text: $playerNames[0])
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            .onChange(of: playerNames[0]) {
                                updateValidNames()
                            }
                        
                        Spacer()
                    }
                    HStack{
                        Text("2")
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        
                        Spacer()
                            .frame(width: 20.0)
                        
                        TextField("Enter name here", text: $playerNames[1])
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            .onChange(of: playerNames[1]) {
                                updateValidNames()
                            }
                        
                        Spacer()
                    }
                    
                    ForEach(2..<playerNames.count, id: \.self) { index in
                        HStack{
                            Text("\(index + 1)")
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            
                            Spacer()
                                .frame(width: 20.0)
                            
                            TextField("Enter name here", text: self.$playerNames[index])
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                .onChange(of: playerNames[index]) {
                                    updateValidNames()
                                }
                            
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                        self.playerNames.append("")
                        updateValidNames()
                    }) {
                        HStack{
                            Spacer()
                            
                            Image(systemName: "plus.circle")
                                .scaleEffect(1.7)
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))

                            Spacer()
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .listRowSpacing(10)
                
                if(validNames) {
                    NavigationLink(destination: StartGameView(playerNames: playerNames)) {
                        Text("Next")
                            .padding(10)
                            .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            .cornerRadius(10)
                            .scaleEffect(1.3)
                    }
                } else {
                    Text("Please fill in all of the names")
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .scaleEffect(1.1)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    func updateValidNames() {
        var emptyNames = 0
        for index in 0..<playerNames.count {
            if(playerNames[index] == "") {
                emptyNames += 1
            }
        }
        
        if(emptyNames == 0) {
            validNames = true
        } else {
            validNames = false
        }
    }
}

#Preview {
    PlayerNamesView()
}
