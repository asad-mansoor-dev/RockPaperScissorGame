//
//  ContentView.swift
//  RPS Game
//
//  Created by Dev on 16/03/2023.
//

import SwiftUI

enum Choice: String{
    case Rock, Paper, Scissor
}

struct ContentView: View {
    @State private var choices = [Choice.Rock, Choice.Paper, Choice.Scissor]
    @State private var myOption = Int.random(in: 0...2)
    @State private var turnResult = ""
    @State private var showResult = false
    @State private var userScore = 0
    @State private var myScore = 0
    @State private var draws = 0
    @State private var turns = 0
    @State private var gameOver = false

    @ViewBuilder var gameScreen: some View{
        VStack{
            Section{
                HStack(spacing: 30) {
                    Button{
                        buttonPressed(0)
                    } label: {
                        Text("✊")
                            .font(.system(size: 50))
                            .padding(10)
                            .border(.indigo, width: 10)
                            .cornerRadius(20)
                    }
                    
                    Button{
                        buttonPressed(1)
                    } label: {
                        Text("✋")
                            .font(.system(size: 50))
                            .padding(10)
                            .border(.indigo, width: 10)
                            .cornerRadius(20)
                    }
                    
                    
                    
                    Button{
                        buttonPressed(2)
                    } label: {
                        Text("✌️")
                            .font(.system(size: 50))
                            .padding(10)
                            .border(.indigo, width: 10)
                            .cornerRadius(20)
                    }
                }
//                HStack(spacing: 20){
//                    Button("ROCK"){
//                        buttonPressed(0)
//                    }
//                    Button("PAPER"){
//                        buttonPressed(1)
//                    }
//                    Button("SCISSOR"){
//                        buttonPressed(2)
//                    }
//                }
//                .font(.headline)
            } header: { Text("Choose an Option")}
            Text("No of Turns: \(turns)")
        }
        .alert(turnResult, isPresented: $showResult) {
            Button("Continue", action: turns < 10 ? playAgain : result )
        } message: {
            Text("I Chose \(choices[myOption].rawValue)")
        }
    }

    @ViewBuilder var scoreScreen: some View{
        VStack{
            Text(userScore >= myScore ? "You Won" : "I Won")
                .font(.largeTitle.weight(.semibold))
                .foregroundColor(.red)
            Text("Your Score: \(userScore)")
            Text("MyScore: \(myScore)")
            Text("Draws: \(draws)")
            Button("Play Again"){
                reset()
            }
        }
    }

    var body: some View {
        VStack{
            if gameOver {
                scoreScreen
            } else {
                gameScreen
            }
        }
    }

    func buttonPressed(_ number: Int) {
        let userGuess = choices[number]
        let myGuess = choices[myOption]
        turns += 1
        if userGuess == myGuess {
            turnResult = "Game Draw!"
            draws += 1
        } else {
            let win = checkForWin(user: userGuess, computer: myGuess)
            if win {
                turnResult = "You Won!"
                userScore += 1
            } else {
                turnResult = "You Lose!"
                myScore += 1
            }
        }
        showResult = true
    }

    func checkForWin(user: Choice, computer: Choice) -> Bool {
        switch user {
        case .Rock:
            return computer == .Scissor
        case .Paper:
            return computer == .Rock
        case .Scissor:
            return computer == .Paper
        }
    }

    func playAgain() {
        myOption = Int.random(in: 0...2)
    }

    func result() {
        gameOver.toggle()
    }

    func reset() {
        gameOver.toggle()
        myScore = 0
        turns = 0
        userScore = 0
        myOption = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
