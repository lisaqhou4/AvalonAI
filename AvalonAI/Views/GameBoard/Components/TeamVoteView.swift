//
//  TeamVoteView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct TeamVoteView: View {
    @EnvironmentObject var game: Game
    @Binding var path: [Route]

    var body: some View {
        VStack {
            if game.voteDecision[cardCnt - 1] != -1 {
                Button(action: {
                    game.voteTeam()
                    path.append(.voteResult)
                }) {
                    Text("Test:voteTeam")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        )
                }
                Text(game.voteDecision[cardCnt - 1] == 1 ? "You approved the team." : "You rejected the team.")
                    .foregroundColor(.white)
            } else
            if game.teamSelection.count > 0 {
                VStack {
                    Text("Leader purposed the following team:")
                        .foregroundColor(.white)
                    ForEach(Array(game.teamSelection).sorted(), id: \.self) { index in
                        if index < cardCnt - 1 {
                            Text("Player \(index + 1)").foregroundColor(.white)
                        } else {
                            Text("Yourself").foregroundColor(.white)
                        }
                    }
                    HStack {
                        Button(action: {
                            game.voteDecision[cardCnt - 1] = 0
                        }) {
                            Text("Reject")
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
                            game.voteDecision[cardCnt - 1] = 1
                        }) {
                            Text("Accept")
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
                }.padding(5).shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
            }
            else {
                if game.leader == cardCnt - 1 {
                    Button {
                        path.append(.teamSelection)
                    } label: {
                        Text("Build Your Team")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                            .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                    }
                } else {
                    Button(action: {
                        game.selectTeam()
                    }) {
                        Text("Test:selectTeam")
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.black)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    }
                    Text("Waiting for the leader to build the team...")
                        .foregroundColor(.white)
                        .padding(5)
                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                }
            }
            
        }
    }
    
    
}



#Preview {
    ZStack {
        Rectangle().background(Color.black)
            .scaledToFill()
            .ignoresSafeArea()
        TeamVoteView(path: .constant([])).environmentObject(Game())
    }
}
