import SwiftUI

struct GameBoardView: View {
    @EnvironmentObject var game: Game

    var body: some View {
        let currQuest = game.nextEmptyQuestIndex()
        GeometryReader { geometry in
            ZStack (alignment: .topLeading) {
                Image("bg_in_game")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack (alignment: .leading){
                    HStack {
                        titleLayout(currQuest: currQuest)
                    }.frame(width: geometry.size.width)
                    HStack (alignment: .top, spacing: 0){
                        playerLayout(cards: game.cards, leader: game.leader)
                        bubbleLayout(index: 3, message: "Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa ")
                    }
                    chatLayout()
                    Spacer()
                    HStack {
                        portraitLayout()
                        questLayout()
                        Button {
                            // open team selection
                        } label: {
                            if game.teamSelection.count > 0 {
                                VStack {
                                    Text("Leader purposed the following team:")
                                        .foregroundColor(.white)
                                    ForEach(Array(game.teamSelection), id: \.self) { player in
                                        Text(player)
                                            .foregroundColor(.white)
                                    }
                                }.padding(5)
                                    .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                            } else {
                                if game.leader == game.cards.count - 1 {
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
                                } else {
                                    Text("Waiting for the leader to build the team...")
                                        .foregroundColor(.white)
                                        .padding(5)
                                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 3)
                                }
                            }
                        }
                    }
                }.frame(width: geometry.size.width, height: geometry.size.height)
                
            }
        }
    }
    
    private func questLayout() -> some View {
        VStack {
            ForEach(0..<(max(game.questHistory.count, 0)), id: \.self) { index in
                HStack {
                    Text("Quest " + String(index + 1)).foregroundColor(.white)
                    if game.questHistory[index] == 1 {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 15, height: 15)
                    } else if game.questHistory[index] == 0 {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 15, height: 15)
                    } else {
                        Circle()
                            .frame(width: 15, height: 15)
                    }
                }
            }
        }
    }
    
    private func titleLayout(currQuest: Int) -> some View {
        VStack(spacing: 2) {
            Text("Quest \(currQuest + 1) (Trial \(game.trial))")
                .foregroundColor(.white)
                .font(.title)
            Text(phases[game.phase])
                .foregroundColor(.white)
            Text("Team Size: " + String(teamSize[currQuest]))
                .foregroundColor(.white)
            if game.leader == game.cards.count - 1 {
                Text("You are the leader").foregroundColor(.white)
            } else {
                Text("Player " + String(game.leader + 1) + " is the leader").foregroundColor(.white)
            }
        }
        .frame(maxWidth: 300)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .black.opacity(0), location: 0),
                    .init(color: .black.opacity(1), location: 0.5),
                    .init(color: .black.opacity(0), location: 1),
                ]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }

    private func playerLayout(cards: [Card], leader: Int) -> some View {
        VStack {
            ForEach(0..<(max(cards.count - 1, 0)), id: \.self) { index in
                HStack (spacing: 0){
                    Image("flag")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .offset(x: 0, y: -15)
                            .opacity(leader == index ? 1 : 0)
                    CardView(card: cards[index], title: "Player " + String(index + 1))
                }
            }
        }
    }
    
    private func chatLayout() -> some View {
        HStack {
            Button {
                // open chat history
            } label: {
                Text("Chat history")
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
            Spacer()
            Button {
                // send message
            } label: {
                Text("Send Message")
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
        }.padding(.horizontal)
    }
    
    
    private func portraitLayout() -> some View {
        ZStack (alignment: .bottomLeading) {
            if let userCard = game.cards.last {
                CardView(card: userCard, title: "You")
            }
            Image("flag")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .opacity(game.leader == game.cards.count - 1 ? 1: 0)
                .offset(x: -10, y: -30)
        }.padding()
    }
    // Helper Function to Simplify Position Calculation
    private func calculatePortraitPosition(for index: Int, in total: Int, size: CGSize) -> CGPoint {
        let spacing: CGFloat = 80
        return CGPoint(
            x: 60.0,
            y: CGFloat(spacing * CGFloat(index) + 120)
        )
    }
    
    private func bubbleLayout(index: Int, message: String) -> some View {
        HStack (alignment: .top, spacing: 0){
            Spacer()
            Triangle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 17, height: 20)
                .rotationEffect(.degrees(-90)) // points left
                .offset(x: 0, y: CGFloat(index * 90 + 15))
            ScrollView {
                    Text(message)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .background(Color.white.opacity(0.5))
                .cornerRadius(16)
        }
        .padding(.horizontal)
        .frame(height: 320, alignment: .top)
    }
}



#Preview {
    let game = Game()
    game.teamSelection = Set([0,1,2])
    
    return ZStack {
        GameBoardView()
            .environmentObject(game)
    }
}
