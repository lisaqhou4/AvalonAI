//
//  VoteResultView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct VoteResultView: View {
    @EnvironmentObject var game: Game
    @Binding var path: [Route]

    var body: some View {
        let result = game.getVoteResult()
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
                    voteResultList(game: game)
                    if game.getVoteResult() {
                        Text("The team is approved")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 200)
                    } else {
                        Text("The team is rejected")
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 200)
                    }
                    
                    Button(action: {
                        if result {
                            game.goToQuestPhase()
                        } else {
                            game.goToNextTrial()
                        }
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
    private func voteResultList(game: Game) -> some View {
            ForEach(game.voteDecision.indices, id: \.self) { index in
                if index < cardCnt - 1 {
                    if game.voteDecision[index] == 1 {
                        Text("Player \(index + 1): Approve").foregroundColor(.white)
                    } else {
                        Text("Player \(index + 1): Reject").foregroundColor(.white)
                    }
                } else {
                    if game.voteDecision[index] == 1 {
                        Text("       You: Approve").foregroundColor(.white)
                    } else {
                        Text("       You: Reject").foregroundColor(.white)
                    }
                }
            }
            
    }
}


struct VoteResultView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game()
        game.teamSelection = Set([0, 1, 2])
        game.voteDecision = [0,0,0,0,0]

        return VoteResultView(path: .constant([]))
            .environmentObject(game)
    }
}
