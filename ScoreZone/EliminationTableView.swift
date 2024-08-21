//
//  EliminationTableView.swift
//  Gamify
//
//  Created by Nithin Bhandari on 7/5/24.
//

import SwiftUI


struct EliminationTableView: View {
    
    @State var playerNames: [String]
    @State var eliminationNumber: Int
    @State var rounds: Int = 1
    @State var roundList: [Int] = [1]
    @State var playerScores: [[Int]]
    @State var totals: [Int]
    @State var temp: String = ""
    @State var eliminations: [Int]
    @State var eliminationList: [Int]
    @State private var showingExitAlert = false
    @State private var showingWinnerAlert = false
    @State private var foundWinner = false
    @State var image = Image(systemName: "multiply")
    
    init(playerNames: [String], eliminationNumber: Int) {
        self.playerNames = playerNames
        self.eliminationNumber = eliminationNumber + 1
        self._playerScores = State(initialValue: Array(repeating: [0], count: playerNames.count))
        self._totals = State(initialValue: Array(repeating: 0, count: playerNames.count))
        self._eliminations = State(initialValue: Array(repeating: 0, count: playerNames.count))
        self._eliminationList = State(initialValue: Array(repeating: 0, count: playerNames.count))
    }
    
    var body: some View {
        
        ZStack {
            Color(Color(red: 0.933, green: 0.925, blue: 0.891))
                .ignoresSafeArea()
            
            VStack {
                Text("Elimination (\(eliminationNumber) to lose)")
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
                                            
                                            if(eliminations[index] == 1 && round >= eliminationList[index]) {
                                                ZStack{
                                                    TextField("", text: $temp)
                                                        .background(Color.white)
                                                        .multilineTextAlignment(.center)
                                                        .cornerRadius(7.5)
                                                        .frame(width: 50.0)
                                                        .disabled(true)
                                                    
                                                    Image(systemName: "multiply")
                                                        .padding(0.5)
                                                        .scaleEffect(1)
                                                        .foregroundColor(.red)
                                                }
                                            } else {
                                                TextField("", value: $playerScores[index][round], format: .number)
                                                    .background(Color.white)
                                                    .multilineTextAlignment(.center)
                                                    .cornerRadius(7.5)
                                                    .frame(width: 50.0)
                                                    .onChange(of: playerScores[index]) {
                                                        updateTotals()
                                                        updateEliminations()
                                                        if(isWinner() != -1) {
                                                            showingWinnerAlert = true;
                                                            foundWinner = true;
                                                        }
                                                    }
                                                    .disabled(eliminations[index] == 1)
                                                    .disabled(foundWinner)
                                            }
                                            
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
                let winner = playerNames[isWinner()]
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
                        
                        Text("Congratulations \(winner)!")
                            .padding()
                            .bold()
                            .frame(width: 225.0, alignment: .center)
                            .scaleEffect(1.2)
                            .multilineTextAlignment(.center)
                        
                        
                        Text("You are the winner of this game!")
                            .frame(width: 250.0, alignment: .center)
                            .padding()
                            .multilineTextAlignment(.center)

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
    
    func updateEliminations() {
        for index in 0..<playerScores.count {
            if(eliminations[index] == 0) {
                if(totals[index] >= eliminationNumber) {
                    eliminations[index] = 1;
                    eliminationList[index] = rounds;
                }
            }
        }
    }
    
    func isWinner() -> Int {
        var countOfZero = 0;
        var winnerIndex = 0;
        for index in 0..<playerScores.count {
            if(eliminations[index] == 0) {
                countOfZero += 1
                winnerIndex = index;
            }
        }
        
        if(countOfZero > 1) {
            return -1;
        }
        
        return winnerIndex;
    }
}


#Preview {
    //EliminationTableView(playerNames: ["Paul", "John", "Chris", "Neff", "Teach", "Bill", "Panda", "Ymca"], eliminationNumber: 100)
    
    EliminationTableView(playerNames: ["Paul", "John", "Chris", "JJ"], eliminationNumber: 100)
}
