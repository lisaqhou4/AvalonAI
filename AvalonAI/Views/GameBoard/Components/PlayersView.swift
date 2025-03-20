//
//  PlayersView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct PlayersView: View {
    let cards: [Card]
    let leader: Int
    var message: String = ""
    var index: Int = 0

    var body: some View {
        HStack (alignment: .top, spacing: 0){
            VStack {
                ForEach(0..<(max(cards.count - 1, 0)), id: \.self) { index in
                    HStack (spacing: 0){
                        Image("flag")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .offset(x: 0, y: -15)
                            .opacity(leader == index ? 1 : 0)
                        CardView(card: cards[index], title: "Player " + String(index + 1))
                    }
                }
            }
            HStack (alignment: .top, spacing: 0){
                Spacer()
                Triangle()
                    .fill(Color.white.opacity(0.5))
                    .frame(width: 17, height: 20)
                    .rotationEffect(.degrees(-90)) // points left
                    .offset(x: 0, y: CGFloat(index * 90 + 15))
                ScrollView {
                    Text(message)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .background(Color.white.opacity(0.5))
                .cornerRadius(16)
            }
            .padding(.horizontal)
            .frame(height: 320, alignment: .top)
        }
    }
}



#Preview {
    let game = Game()
    game.teamSelection = Set([0,1])
    return PlayersView(cards: game.cards, leader: 0, message: "aaaaa")
}
