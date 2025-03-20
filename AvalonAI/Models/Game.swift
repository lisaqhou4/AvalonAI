import SwiftUI

class Game: ObservableObject {
    @Published var cards = generateRandomCards()
    @Published var leader = Int.random(in: 0..<availableCards.count)
    @Published var teamSelection: Set<Int> = []
    @Published var questHistory = [-1, -1, -1, -1, -1]
    @Published var phase = 0
    @Published var trial = 1
    //    @Published var score = 0
    func reset() {
        cards = generateRandomCards()
        leader = Int.random(in: 0..<cards.count)
        // reset other stuff
    }
    func nextEmptyQuestIndex() -> Int {
        return questHistory.firstIndex(of: -1) ?? -1
    }
    func evaluateQuest() {
        
    }
}

let phases: [String] = ["Team Building Phase", "Quest Phase"]
let teamSize: [Int] = [2,3,2,3,3]
let questNum = 5
// Card Types
let availableCards: [Card] = [
    Card(role: "Servant"),
    Card(role: "Assassin"),
    Card(role: "Merlin"),
    Card(role: "Percival"),
    Card(role: "Morcana")
]

// Random Card Generator
func generateRandomCards() -> [Card] {
    let shuffledCards = availableCards.shuffled()

    var result: [Card] = []

    for (i, card) in shuffledCards.enumerated() {
        var updatedCard = Card(role: card.role)
        // If it's the last card, mark as player's card
        if i == shuffledCards.count - 1 {
            updatedCard.isPlayer = true
        }
        result.append(updatedCard)
    }

    return result
}
