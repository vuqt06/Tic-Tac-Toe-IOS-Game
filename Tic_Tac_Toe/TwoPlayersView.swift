//
//  2PlayersView.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 12/30/21.
//

import SwiftUI

struct TwoPlayersView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        GeometryReader {
            geo in
            VStack {
                Spacer()
                Text("2 Players Mode").font(Font.custom("asphyxiate", size: 30)).foregroundColor(.yellow)
                    
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 8) {
                    ForEach(0..<9) {
                        index in
                        ZStack {
                            CircleView(proxy: geo)
                            
                            PlayerIndicatorView(systemImageName: viewModel.moves[index]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processMove2Players(in: index)
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

struct TwoPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        TwoPlayersView()
    }
}

