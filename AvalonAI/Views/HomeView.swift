import SwiftUI

struct HomeView: View {
    @State private var showPlayerRole = false
    @StateObject private var game = Game()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("bg_home")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("AVALON")
                        .font(.custom("MedievalSharp", size: 48))
                        .foregroundColor(.yellow)
                        .shadow(radius: 3)

                    // Start Game Button
                    Button {
                        game.reset()
                        showPlayerRole = true
                    } label: {
                        Text("Start Game")
                            .padding()
                            .frame(maxWidth: 300)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .black.opacity(0), location: 0),
                                        .init(color: .black.opacity(0.6), location: 0.5),
                                        .init(color: .black.opacity(0), location: 1),
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
            .navigationDestination(isPresented: $showPlayerRole) {
                PlayerRoleView()
                    .environmentObject(game)
            }
        }
        .environmentObject(game)
    }
}

#Preview {
    HomeView()
}

