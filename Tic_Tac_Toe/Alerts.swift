//
//  Alerts.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 11/25/21.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title:Text
    var message:Text
    var buttonTitle:Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win!"), message: Text("You are so smart"), buttonTitle: Text("Beat the computer again"))
    static let computerWin = AlertItem(title: Text("You lose!"), message: Text("The computer is so smart"), buttonTitle: Text("Revenge"))
    static let p1Win = AlertItem(title: Text("Player 1 win!"), message: Text("Player 1 is so smart"), buttonTitle: Text("Rematch"))
    static let p2Win = AlertItem(title: Text("Player 2 win!"), message: Text("Player 2 is so smart"), buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("Draw!"), message: Text("That was close"), buttonTitle: Text("Rematch"))
}

