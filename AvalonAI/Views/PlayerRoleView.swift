import SwiftUI

struct PlayerRoleView: View {
    @EnvironmentObject var game: Game

    var body: some View {
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
                if let userCard = game.cards.last {
                    CardView(card: userCard)
                        .frame(width: 100, height: 150)
                    
                    Text(userCard.description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 200)
                }
                
                NavigationLink(destination: GameBoardView()) {
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


#Preview {
    PlayerRoleView().environmentObject(Game())
}
