import SwiftUI


enum Route: Hashable {
    case voteResult
    case questResult
    case gameBoard
    case playerRole
    case teamSelection
}
struct HomeView: View {
    @StateObject private var game = Game()
    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
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
                        path.append(.playerRole)
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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .playerRole:
                    PlayerRoleView(path: $path)
                case .voteResult:
                    VoteResultView(path: $path)
                case .gameBoard:
                    GameBoardView(path: $path)
                case .teamSelection:
                    TeamSelectionView(path: $path)
                case .questResult:
                    QuestResultView(path: $path)
                default:
                    EmptyView()
                }
            }
        }.environmentObject(game)
    }
}

#Preview {
    HomeView()
}
