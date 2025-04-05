//
//  QuestResult.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct QuestResultView: View {
    @EnvironmentObject var game: Game
    @Binding var path: [Route]

    var body: some View {
        let result = game.getQuestResult()
        let onesCount = game.questResult.filter { $0 == 1 }.count
        let zerosCount = game.questResult.filter { $0 == 0 }.count
        ZStack {
            Image("bg_in_game")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                )
            
            VStack(spacing: 16) {
                Text("Success: \(onesCount)         ").foregroundColor(.white)
                Text("Fail: \(zerosCount)").foregroundColor(.white)
                
                Text(result ? "The quest succeed": "The quest failed")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 200)
                
                Button(action: {
                    game.goToNextQuest()
                    path.append(.gameBoard)
                }) {
                    Text("OK")
                        .padding()
                        .frame(maxWidth: 300)
                        .background(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.black.opacity(0), location: 0.0),
                                    .init(color: Color.black.opacity(1), location: 0.5),
                                    .init(color: Color.black.opacity(0), location: 1.0),
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        
    }
}


struct QuestResultView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        game.teamSelection = Set([0, 1])
        game.voteDecision = [0,0,0,0,0]
        game.questResult = [1,0]

        return QuestResultView(path: .constant([]))
            .environmentObject(game)
    }
}
