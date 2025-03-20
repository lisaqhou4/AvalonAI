import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
}
// Card Types
let availableCards: [Card] = [
    Card(title: "Knight", color: .blue),
    Card(title: "Assassin", color: .red),
    Card(title: "Merlin", color: .purple),
    Card(title: "Percival", color: .green),
    Card(title: "Morgana", color: .black)
]

// Random Card Generator
func generateRandomCards() -> [Card] {
    var shuffledCards = availableCards.shuffled()
    
    // Add random variation to colors or titles if needed
    shuffledCards.append(Card(title: "You(Role name)", color: .cyan)) // User Card
    return shuffledCards
}
