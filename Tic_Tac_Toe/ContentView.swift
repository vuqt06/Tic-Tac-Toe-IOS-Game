//
//  ContentView.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())];
    
    @State private var moves:[Move?] = Array(repeating: nil, count: 9)
    @State private var positionDisabled:Bool = false
    @State private var alert:AlertItem?
    
    var body: some View {
        GeometryReader {
            geo in
            VStack {
                Spacer()
                Text("Tic Tac Toe").font(Font.custom("asphyxiate", size: 30)).foregroundColor(.yellow)
                    
                Spacer()
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(0..<9) {
                        index in
                        ZStack {
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: geo.size.width/3 - 10, height: geo.size.height/5 - 15)
                                .cornerRadius(5)
                            
                            Image(systemName: moves[index]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                        .onTapGesture {
                            if (isOccupied(in: moves, forIndex: index)) {
                                return
                            }
                            moves[index] = Move(player: .human, boardIndex: index)
                            // Check for win or draw
                            if (winCondition(for: .human, in: moves)) {
                                alert = AlertContext.humanWin
                                return
                            }
                            
                            if (drawCondition(in: moves)) {
                                alert = AlertContext.draw
                                return
                            }
                            positionDisabled = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerMovePosition = computerMovePosition(in: moves)
                                moves[computerMovePosition] = Move(player: .computer, boardIndex: computerMovePosition)
                                if (winCondition(for: .computer, in: moves)) {
                                    alert = AlertContext.computerWin
                                    return
                                }
                                if (drawCondition(in: moves)) {
                                    alert = AlertContext.draw
                                    return
                                }
                                positionDisabled = false
                            }
                        }
                    }
                }.padding([.horizontal], 8)
                Spacer()
            }.disabled(positionDisabled)
                .alert(item: $alert, content: { al in
                    Alert(title: al.title, message: al.message, dismissButton: .default(al.buttonTitle, action: {resetGame()}))
                })
            .background(.black)
                
        }
        .ignoresSafeArea()
    }
    
    func isOccupied(in moves:[Move?], forIndex index:Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func computerMovePosition(in moves:[Move?]) -> Int {
        var position = Int.random(in: 0..<9)
        while (isOccupied(in: moves, forIndex: position)) {
            position = Int.random(in: 0..<9)
        }
        return position
    }
    
    func winCondition(for player:Player, in moves:[Move?]) -> Bool {
        let winStraight:Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter {$0.player == player}
        
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for straight in winStraight where straight.isSubset(of: playerPositions) {
            return true
        }
        return false
    }
    
    func drawCondition(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player:Player
    let boardIndex:Int
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
