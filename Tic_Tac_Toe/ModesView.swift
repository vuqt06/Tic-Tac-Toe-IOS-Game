//
//  ModesView.swift
//  Tic_Tac_Toe
//
//  Created by Vu Trinh on 12/30/21.
//

import SwiftUI

struct ModesView: View {
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
                    Text("Choose mode")
                        .font(Font.custom("PermanentMarker", size: 30)).foregroundColor(.black)
                    Spacer()
                    VStack(spacing: 20) {
                        NavigationLink {
                            EasyGameView().navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 120, height: 60, alignment: .center)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("Easy")
                                    .accentColor(Color.yellow)
                            }
                        }
                        
                        NavigationLink {
                            MediumGameView().navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 120, height: 60, alignment: .center)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("Medium")
                                    .accentColor(Color.yellow)
                            }
                        }
                        
                        NavigationLink {
                            GameView().navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 120, height: 60, alignment: .center)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("Hard")
                                    .accentColor(Color.yellow)
                            }
                        }
                        
                        NavigationLink {
                            TwoPlayersView().navigationBarBackButtonHidden(true)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(width: 120, height: 60, alignment: .center)
                                    .foregroundColor(Color.black)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                
                                Text("2 Players")
                                    .accentColor(Color.yellow)
                            }
                        }
                    }
                    Spacer()
                }
                
                
            }.ignoresSafeArea()
        }
    }
}

struct ModesView_Previews: PreviewProvider {
    static var previews: some View {
        ModesView()
    }
}
