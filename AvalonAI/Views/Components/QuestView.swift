//
//  QuestView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-02.
//

import SwiftUI

struct QuestView: View {
    let card: Card
    let width: CGFloat = 100
    let height: CGFloat = 150

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                if card.isPlayer {
                    Image("card_\(card.role)")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .shadow(radius: 2)
                } else {
                    Image("hidden")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .clipped()
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .shadow(radius: 2)
                }
            }
        }
    }
}

#Preview {
    QuestView(card: Card(role: "Merlin", isPlayer: true))
//    CardView(card: Card(role: "Merlin"))
}
