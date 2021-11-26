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
    static let humanWin = AlertItem(title: Text("You win"), message: Text("You are so smart"), buttonTitle: Text("Beat the IA again"))
    static let computerWin = AlertItem(title: Text("You lose"), message: Text("The AI is so smart"), buttonTitle: Text("Revenge"))
    static let draw = AlertItem(title: Text("Draw"), message: Text("Do not give up"), buttonTitle: Text("Rematch"))
}

