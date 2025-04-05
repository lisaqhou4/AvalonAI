//
//  QuestVoteView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct QuestVoteView: View {
    @EnvironmentObject var game: Game
    @State private var selected: Bool = false
    @Binding var path: [Route]

    var body: some View {
        VStack {
            if game.teamSelection.contains(cardCnt - 1) && !selected {
                if game.cards[cardCnt - 1].isEvil {
                    Text("You are from the evil team. Select one from below:")
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                    HStack {
                        Button(action: {
                            game.questResult.append(0)
                            selected = true
                        }) {
                            Text("Fail")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                        Button(action: {
                            game.questResult.append(1)
                            selected = true
                        }) {
                            Text("Success")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                        }
                    }
                } else {
                    Button(action: {
                        game.startQuest()
                        path.append(.questResult)
                    }) {
                        Text("Test:start the Quest")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    }
                    Text("You are from the good team. You have selected success.")
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                    Text("Waiting for the quest result...")
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                }
            } else {
                Button(action: {
                    game.startQuest()
                    path.append(.questResult)
                }) {
                    Text("Test:start the Quest")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                Text("Waiting for the quest result...")
                    .foregroundColor(.white)
                    .padding(5)
                    .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
            }
        }
    }
}


struct QuestVoteView_Previews: PreviewProvider {
    static var previews: some View {
            PreviewWrapper()
        }

    struct PreviewWrapper: View {
        @State var path: [Route] = []

        var body: some View {
            let game = Game()
            game.teamSelection = Set([0, 4])
            game.goToQuestPhase()

            return QuestVoteView(path: $path)
                .environmentObject(game)
        }
    }
}
