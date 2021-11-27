//
//  GameView.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 11/13/21.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    

    var body: some View {
        GeometryReader {
            geo in
            VStack {
                Spacer()
                Text("Tic Tac Toe").font(Font.custom("asphyxiate", size: 30)).foregroundColor(.yellow)
                    
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 8) {
                    ForEach(0..<9) {
                        index in
                        ZStack {
                            CircleView(proxy: geo)
                            
                            PlayerIndicatorView(systemImageName: viewModel.moves[index]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processMove(in: index)
                        }
                    }
                }.padding([.horizontal], 8)
                Spacer()
            }.disabled(viewModel.positionDisabled)
                .alert(item: $viewModel.alert, content: { al in
                    Alert(title: al.title, message: al.message, dismissButton: .default(al.buttonTitle, action: {viewModel.resetGame()}))
                })
            .background(.black)
                
        }
        .ignoresSafeArea()
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
        GameView()
    }
}

struct CircleView: View {
    var proxy:GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.yellow)
            .frame(width: proxy.size.width/3 - 10, height: proxy.size.height/5 - 15)
            .cornerRadius(5)
    }
}

struct PlayerIndicatorView: View {
    var systemImageName:String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.black)
    }
}
