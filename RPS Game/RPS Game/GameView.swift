//
//  GameView.swift
//  RockPaperScissor
//
//  Created by Dev on 3/6/23.
//  Copyright © 2023 Devsinc. All rights reserved.
//

import SwiftUI

enum RPS: String {
    case rock, paper, scissor
}
enum GameStatus: String {
    case WON, LOSE, DRAWN, NONE
}
struct GameView: View {
    @State var items = ["✋", "✊", "✌️"].shuffled()
    @State var shouldWin = true
    @State var points = 0
    @State var round = 0
    @State var shouldShowTotalScore = false
    @State var shouldShowRoundScore = false
    @State var gameStatus = GameStatus.NONE
    
    var body:  some View {
        ZStack {
            Color(red: 255/255, green: 182/255, blue: 193/255)
                .ignoresSafeArea()
            
            VStack {
                HStack{
                    Text("Round \(round)")
                        .font(.system(size: 40).weight(.medium))
                        .foregroundColor(.indigo)
                }
                .padding()
                Spacer()
                VStack {
                    Text("😊")
                        .font(.system(size: 50))
                    
                    Text("I'm done, now your turn!")
                        .font(.headline.weight(.heavy))
                }
                
                Spacer()
                
                VStack {
                    HStack(spacing: 30) {
                        Button{
                            executeRound(selectedOption: "✋")
                        } label: {
                            Text("✋")
                                .font(.system(size: 50))
                                .padding(10)
                                .border(.indigo, width: 10)
                                .cornerRadius(20)
                        }
                        
                        Button{
                            executeRound(selectedOption: "✊")
                        } label: {
                            Text("✊")
                                .font(.system(size: 50))
                                .padding(10)
                                .border(.indigo, width: 10)
                                .cornerRadius(20)
                        }
                        
                        Button{
                            executeRound(selectedOption: "✌️")
                        } label: {
                            Text("✌️")
                                .font(.system(size: 50))
                                .padding(10)
                                .border(.indigo, width: 10)
                                .cornerRadius(20)
                        }
                    }
                    Text("Choose your move to: \(shouldWin ? "Win": "Lose")")
                        .font(.headline.weight(.heavy))
                }
                
                
                Spacer()
                
                Text("Score: \(points)")
                    .font(.headline.weight(.heavy))
                
                Spacer()
            }
        }
        .alert("Game Over", isPresented: $shouldShowTotalScore) {
            Button("OK", role: .cancel) {
                startNewGame()
            }
        } message: {
            Text("You scored \(points) points")
        }
        .alert(gameStatus == .DRAWN ? "Game is DRAWN" : "You have \(gameStatus.rawValue) the Game", isPresented: $shouldShowRoundScore) {
            Button("OK", role: .cancel) {
                if round > 9 {
                    shouldShowTotalScore = true
                }
                else {
                    startNewRound()
                }
            }
        } message: {
            Text((gameStatus == .LOSE || gameStatus == .DRAWN) ? "I had chosen \(getShapeTitle(string:items[0])!.rawValue) 😊": "You scored 10 points, I had chosen \(getShapeTitle(string:items[0])!.rawValue)")
        }
    }
    
    func executeRound(selectedOption: String) {
        
        let result = didWon(selectedOption: selectedOption)
        //check if game drawn
        if selectedOption == items[0] {
            gameStatus = .DRAWN
        }
        else if result {
            points += 10
            gameStatus = .WON
        }
        else if !result {
            points -= 10
            gameStatus = .LOSE
        }
        shouldShowRoundScore = true
    }
    func getShapeTitle(string: String) -> RPS? {
        switch string {
        case "✋":
            return RPS.paper
        case "✊":
            return RPS.rock
        case "✌️":
            return RPS.scissor
        default:
            return nil
        }
    }
    func didWon(selectedOption: String) -> Bool{
        
        let userSelectedShape = getShapeTitle(string: selectedOption)
        let systemSelectedShape = getShapeTitle(string: items[0])
        
        if  systemSelectedShape == .rock && shouldWin && userSelectedShape == .scissor{
            return true
        }
        else if systemSelectedShape == .paper && shouldWin && userSelectedShape == .rock{
            return true
        }
        else if systemSelectedShape == .scissor && shouldWin && userSelectedShape == .paper{
            return true
        }
        else if systemSelectedShape == .rock && !shouldWin && userSelectedShape != .scissor{
            return true
        }
        else if systemSelectedShape == .paper && !shouldWin && userSelectedShape != .rock{
            return true
        }
        else if systemSelectedShape == .scissor && !shouldWin && userSelectedShape != .paper{
            return true
        }
        return false
    }
    func startNewRound() {
        shouldWin = !shouldWin
        items.shuffle()
        round += 1
    }
    func startNewGame() {
        shouldWin = true
        items.shuffle()
        round = 0
        points = 0
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
