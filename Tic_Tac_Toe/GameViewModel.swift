//
//  GameViewModel.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 11/27/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())];
    
    @Published var moves:[Move?] = Array(repeating: nil, count: 9)
    @Published var positionDisabled:Bool = false
    @Published var alert:AlertItem?
    
    func processMove(in position:Int) {
        if (isOccupied(in: moves, forIndex: position)) {
            return
        }
        moves[position] = Move(player: .human, boardIndex: position)
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
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
    
    func isOccupied(in moves:[Move?], forIndex index:Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func computerMovePosition(in moves:[Move?]) -> Int {
        
        // If AI can win, then win
        let winStraight:Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        let computerMoves = moves.compactMap { $0 }.filter {$0.player == .computer}
        
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        for straight in winStraight {
            let winPositions = straight.subtracting(computerPositions)
            if (winPositions.count == 1) {
                if (!isOccupied(in: moves, forIndex: winPositions.first!)) {
                    return winPositions.first!
                }
            }
        }
        
        // If AI can't win, then block player
        let humanMoves = moves.compactMap { $0 }.filter {$0.player == .human}
        
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        for straight in winStraight {
            let winPositions = straight.subtracting(humanPositions)
            if (winPositions.count == 1) {
                if (!isOccupied(in: moves, forIndex: winPositions.first!)) {
                    return winPositions.first!
                }
            }
        }
        
        // If AI can't block or win, take the middle square
        let centerSquare = 4
        if (!isOccupied(in: moves, forIndex: centerSquare)) {
            return centerSquare
        }
        
        // If AI can't take middle square, take random available square
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
