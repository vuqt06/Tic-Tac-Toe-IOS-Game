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
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                    }
                }.padding([.horizontal], 8)
                Spacer()
            }.background(.black)
                
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
