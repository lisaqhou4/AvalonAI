import SwiftUI

class Game: ObservableObject {
    @Published var cards = generateRandomCards()
    @Published var leader = Int.random(in: 0..<availableCards.count)
    @Published var teamSelection: Set<Int> = []
    @Published var questResult: [Int] = []
    @Published var phase = 0
    @Published var trial = 1
    @Published var questHistory = [-1, -1, -1, -1, -1]
    @Published var voteDecision = [-1, -1, -1, -1, -1]
    //    @Published var score = 0
    func reset() {
        cards = generateRandomCards()
        leader = Int.random(in: 0..<cards.count)
        teamSelection = []
        questResult = []
        phase = 0
        trial = 1
        questHistory = [-1, -1, -1, -1, -1]
        voteDecision = [-1, -1, -1, -1, -1]
        // reset other stuff
    }
    func nextEmptyQuestIndex() -> Int {
        return questHistory.firstIndex(of: -1) ?? -1
    }
    func evaluateQuest() {
        
    }
    func selectTeam() {
        // AI select Team
        let allTeams = Array(0..<cardCnt)
        let selected = allTeams.shuffled().prefix(teamSize[nextEmptyQuestIndex()])
        teamSelection = Set(selected)
    }
    func voteTeam() {
        // AI vote Team
        for index in 0..<max(cardCnt - 1, 0) {
            voteDecision[index] = Int.random(in: 0..<2)
        }
    }
    func startQuest() {
        // AI select quest
        for player in Array(teamSelection).sorted() {
            if player < cardCnt - 1 {
                questResult.append(Int.random(in: 0..<2))
            }
        }
    }
    func getVoteResult() -> Bool {
        let onesCount = voteDecision.filter { $0 == 1 }.count
        let zerosCount = voteDecision.filter { $0 == 0 }.count
        return onesCount > zerosCount
    }
    func getQuestResult() -> Bool {
        let zerosCount = questResult.filter { $0 == 0 }.count
        return !(zerosCount > 0)
    }
    func goToNextTrial() {
        if trial == 5 {
            // Evil wins
        }
        trial += 1
        leader = (leader + 1) % cardCnt
        teamSelection = []
        questResult = []
        voteDecision = [-1, -1, -1, -1, -1]
    }
    func goToQuestPhase() {
        phase = 1
    }
    func goToNextQuest() {
        let index = nextEmptyQuestIndex()
        questHistory[index] = getQuestResult() ? 1 : 0
        phase = 0
        trial = 1
        leader = (leader + 1) % cardCnt
        teamSelection = []
        questResult = []
        voteDecision = [-1, -1, -1, -1, -1]
    }
}

let phases: [String] = ["Team Building Phase", "Quest Phase"]
let teamSize: [Int] = [2,3,2,3,3]
let questNum = 5
let cardCnt = 5
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
