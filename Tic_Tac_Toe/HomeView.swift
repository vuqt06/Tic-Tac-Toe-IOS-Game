//
//  HomeView.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 12/29/21.
//

import SwiftUI

struct HomeView: View {
    static let gradientStart = Color(red: 255/255, green: 211/255, blue: 0/255)
    static let gradientEnd = Color(red: 252/255, green: 244/255, blue: 163/255)

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(
                        gradient: .init(colors: [Self.gradientStart, Self.gradientEnd]),
                        startPoint: .init(x: 0.5, y: 0),
                        endPoint: .init(x: 0.5, y: 0.5)
                      ))
                
                VStack {
                    Spacer()
                    Text("Tic Tac Toe")
                        .font(Font.custom("asphyxiate", size: 30)).foregroundColor(.black)
                    Spacer()
                    
                    NavigationLink {
                        GameView()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 90, height: 60, alignment: .center)
                                .foregroundColor(Color.black)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            
                            Text("Start")
                                .accentColor(Color.yellow)
                        }
                    }

                    Spacer()
                }
                
            }.ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
