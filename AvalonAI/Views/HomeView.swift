import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to AvalonAI")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: GameBoardView(cards: generateRandomCards())) {
                    Text("Start Game")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
