//
//  TeamSelectionView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct TeamSelectionView: View {
    @EnvironmentObject var game: Game
    @State private var path: [Route] = []

    enum Route: Hashable {
        case gameBoard
    }
    let allPlayers = ["Player 1", "Player 2", "Player 3", "Player 4", "Yourself"]

    @State private var selectedPlayers: Set<Int> = []

    var body: some View {
        let size = teamSize[game.nextEmptyQuestIndex()]
        
        NavigationStack(path: $path) {
            ZStack {
                Image("bg_in_game")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                    )
            VStack(spacing: 12) {
                    Text("Build Your Team")
                        .padding()
                        .font(.title)
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
                    Text("It is a time for great decisions and strong leaders. Not all knights and ladies of Avalon are loyal to Arthur, and yet you must choose only those that are Good to represent him in his quests. If an open ear and eye is kept, Merlin’s sage advice can be discerned as whispers of truth.")
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 300)
                    Text("Select up to \(size) players:")
                        .font(.headline).foregroundColor(.white)

                    ForEach(0..<allPlayers.count, id: \.self) { index in
                        Button(action: {
                            toggleSelection(for: index, size: size)
                        }) {
                            HStack {
                                Text(allPlayers[index]).foregroundColor(.white)
                                Spacer()
                                if selectedPlayers.contains(index) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                }
                            }
                            .cornerRadius(10)
                            .frame(width: 200)
                        }
                        .disabled(!selectedPlayers.contains(index) && selectedPlayers.count >= size)
                    }
                HStack {
                    Button(action: {
                        path.append(.gameBoard)
                    }) {
                        Text("Cancel")
                            .padding()
                            .frame(maxWidth: 150)
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
                    Button(action: {
                        game.teamSelection = selectedPlayers
                    }) {
                        Text("Confirm")
                            .padding()
                            .frame(maxWidth: 150)
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
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                    case .gameBoard:
                        GameBoardView()
                }
            }
        }
        
        }
    }

    private func toggleSelection(for player: Int, size: Int) {
        if selectedPlayers.contains(player) {
            selectedPlayers.remove(player)
        } else if selectedPlayers.count < size {
            selectedPlayers.insert(player)
        }
    }
}


#Preview {
    TeamSelectionView().environmentObject(Game())
}
