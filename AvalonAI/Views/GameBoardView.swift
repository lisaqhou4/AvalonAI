import SwiftUI

struct GameBoardView: View {
    @State private var isLandscape: Bool = false

    let cards: [Card]

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            Group {
                if isLandscape {
                    landscapeLayout(geometry: geometry)
                } else {
                    portraitLayout(geometry: geometry)
                }
            }
        }
    }

    // MARK: - Portrait Layout
    private func portraitLayout(geometry: GeometryProxy) -> some View {
            ZStack {
                ForEach(0..<(max(cards.count - 1, 0)), id: \.self) { index in
                    let position = calculateProtraitPosition(for: index, in: cards.count - 1, size: geometry.size)

                    CardView(card: cards[index])
                        .position(position)
                }

                if let userCard = cards.last {
                    CardView(card: userCard)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - 60
                        )
                }
            }
    }

    // MARK: - Landscape Layout
    private func landscapeLayout(geometry: GeometryProxy) -> some View {
            ZStack {
                ForEach(0..<(max(cards.count - 1, 0)), id: \.self) { index in
                    let position = calculateLandscapePosition(for: index, in: cards.count - 1, size: geometry.size)

                    CardView(card: cards[index])
                        .position(position)
                }

                if let userCard = cards.last {
                    CardView(card: userCard)
                        .position(
                            x: geometry.size.width / 2,
                            y: geometry.size.height - 60
                        )
                }
            }
    }

    // Helper Function to Simplify Position Calculation
    private func calculateLandscapePosition(for index: Int, in total: Int, size: CGSize) -> CGPoint {
        let spacing: CGFloat = 150
        if index == 0 {
            return CGPoint(
                x: 100,
                y: size.height / 2
            )
        }
        if index == total - 1 {
            return CGPoint(
                x: size.width - 100,
                y: size.height / 2
            )
        } else {
            // Distribute middle cards symmetrically from the center
            let middleIndex = total / 2
            let offset = CGFloat(index - middleIndex) * spacing
            return CGPoint(
                x: size.width / 2 + offset, // Offset from center
                y: 100  // Position higher on the screen
            )
        }
    }
    
    // Helper Function to Simplify Position Calculation
    private func calculateProtraitPosition(for index: Int, in total: Int, size: CGSize) -> CGPoint {
        let spacing: CGFloat = 200
        
        if index < total / 2 {
            return CGPoint(
                x: 60.0,
                y: CGFloat(spacing * CGFloat(index + 1) + 50)
            )
        } else if index > total / 2 {
            return CGPoint(
                x: size.width - 60.0,
                y: CGFloat(spacing * CGFloat(index - total / 2) + 50)
            )
        } else if total % 2 != 0 {
            return CGPoint(
                x: size.width / 2,
                y: 100
            )
        } else {
            return CGPoint(
                x: size.width - 100.0,
                y: 100.0 * CGFloat(index)
            )
        }
    }
        
}


#Preview {
    GameBoardView(cards: generateRandomCards())
}
