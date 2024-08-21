//
//  ScoreTableView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/5/24.
//

import SwiftUI

struct ScoreTableView: View {
    @State var playerNames: [String]
    @State var maxRounds: Int
    @State var rounds: Int = 1
    @State var roundList: [Int] = [1]
    @State var playerScores: [[Int]]
    @State var totals: [Int]
    @State var temp: String = ""
    @State private var showingExitAlert = false
    @State private var showingWinnerAlert = false
    @State private var foundWinner = false
    
    init(playerNames: [String], maxRounds: Int) {
        self.playerNames = playerNames
        self.maxRounds = maxRounds + 1
        self._playerScores = State(initialValue: Array(repeating: [0], count: playerNames.count))
        self._totals = State(initialValue: Array(repeating: 0, count: playerNames.count))
    }
    
    var body: some View {
        
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Text("Score (\(maxRounds) rounds)")
                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                    .scaleEffect(1.2)
                Spacer()
                    .frame(height: 30.0)
                ScrollView {
                    HStack {
                        VStack() {
                            Text("Round")
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            ForEach(0..<rounds, id: \.self) { index in
                                
                                
                                TextField("", value: $roundList[index], format: .number)
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                    .frame(width: 10.0)
                                    .multilineTextAlignment(.center)
                                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            }
                            
                            Text("Total")
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(0..<playerNames.count, id: \.self) { index in
                                    
                                    VStack {
                                        Text("\(playerNames[index])")
                                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                        
                                        ForEach(0..<rounds, id: \.self) { round in
                                            
                                            TextField("", value: $playerScores[index][round], format: .number)
                                                .background(Color.white)
                                                .multilineTextAlignment(.center)
                                                .cornerRadius(7.5)
                                                .frame(width: 50.0)
                                                .onChange(of: playerScores[index]) {
                                                    updateTotals()
                                                }
                                                .disabled(foundWinner)
                                            
                                        }
                                        
                                        Text("\(totals[index])")
                                            .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                        
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    if rounds < maxRounds {
                        Button(action: {
                            for index in 0..<playerScores.count {
                                playerScores[index].append(0)
                            }
                            roundList.append(rounds+1)
                            rounds += 1
                            updateTotals()
                        }) {
                            HStack{
                                Text("Next round   ")
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                    .scaleEffect(1)
                                
                                Image(systemName: "plus.circle")
                                    .scaleEffect(1.7)
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                            }
                        }
                    } else {
                        if(foundWinner) {
                            Button("View Winner") {
                                showingWinnerAlert = true
                            }
                                .padding(10)
                                .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                .cornerRadius(10)
                                .scaleEffect(1.3)
                        } else {
                            Button("Find Winner") {
                                showingWinnerAlert = true
                                foundWinner = true
                            }
                                .padding(10)
                                .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                                .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                                .cornerRadius(10)
                                .scaleEffect(1.3)
                        }
                    }
                    
                    Spacer()
                    
                    Button("Exit Game") {
                        showingExitAlert = true
                    }
                        .padding(10)
                        .background(Color(red: 0.875, green: 0.826, blue: 0.766))
                        .foregroundColor(Color(hue: 0.0, saturation: 0.205, brightness: 0.332))
                        .cornerRadius(10)
                        .scaleEffect(1.3)
                        .alert("Are you sure you would like to leave the game?", isPresented: $showingExitAlert) {
                            Button("Cancel") {
                                showingExitAlert = false
                            }
                            
                            NavigationLink(destination: ContentView()) {
                                Text("Exit")
                            }
                        }
                     
                    Spacer()
                }
            }
            .padding()
            
            if(showingWinnerAlert) {
                let winner = findWinner()
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()

                    VStack {
                        HStack {
                            Spacer()

                            Button(action: {
                                showingWinnerAlert = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 20))
                            }
                            .padding()
                        }
                        
                        Image("trophy")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 100.0)
                            .scaleEffect(0.3)
                        
                        Spacer()
                        
                        if(winner.count == 1) {
                            Text("Congratulations \(winner[0])!")
                                .padding()
                                .bold()
                                .frame(width: 225.0, alignment: .center)
                                .scaleEffect(1.2)
                                .multilineTextAlignment(.center)
                            
                            
                            Text("You are the winner of this game!")
                                .frame(width: 250.0, alignment: .center)
                                .padding()
                                .multilineTextAlignment(.center)
                        } else {
                            Text("Congratulations \(winner.joined(separator: ", "))!")
                                .padding()
                                .bold()
                                .frame(width: 225.0, alignment: .center)
                                .scaleEffect(1.2)
                                .multilineTextAlignment(.center)
                            
                            
                            Text("You all tied for the winner of this game!")
                                .frame(width: 250.0, alignment: .center)
                                .padding()
                                .multilineTextAlignment(.center)
                        }

                        Spacer()
                    }
                    .frame(width: 300, height: 400)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func updateTotals() {
        totals = playerScores.map { $0.reduce(0, +) }
    }
    
    func findWinner() -> [String] {
        guard !totals.isEmpty else {
            return ["No players"]
        }
        
        var maxVal = totals[0]
        var maxIndex = 0
        
        for index in 0..<totals.count {
            if totals[index] > maxVal {
                maxVal = totals[index]
                maxIndex = index
            }
        }
        
        var list = [playerNames[maxIndex]]
        
        for index in 0..<totals.count {
            if totals[index] == maxVal && index != maxIndex{
                list.append(playerNames[index])
            }
        }
        
        return list
    }
}

#Preview {
    ScoreTableView(playerNames: ["Paul", "John", "Chris", "Neff", "Teach", "Bill", "Panda", "Ymca"], maxRounds: 5)
}

