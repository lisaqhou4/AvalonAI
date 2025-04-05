//
//  PlayersView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))    // top point
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom right
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // bottom left
        path.closeSubpath()
        return path
    }
}

struct PlayersView: View {
    let cards: [Card]
    let leader: Int
    var index: Int = 0
    var message: String = ""

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
    PlayersView(cards: Game().cards, leader: 0, message: "aaaaa")
}
