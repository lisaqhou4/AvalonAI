import SwiftUI

struct CardView: View {
    let card: Card
    var title: String = ""
    let width: CGFloat = 100
    let height: CGFloat = 150
    
    var body: some View {
        VStack {
            if card.isPlayer {
                Image("card_\(card.role)")
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .shadow(radius: 2)
            } else {
                Image("hidden")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .shadow(radius: 2)
            }
            if title != "" {Text(title).foregroundColor(.white)}
        }
    }
}

#Preview {
<<<<<<< HEAD
    ZStack {
        Rectangle().background(Color.black)
            .scaledToFill()
            .ignoresSafeArea()
//        CardView(card: Card(role: "Merlin", isPlayer: true), title: "You"))
//        CardView(card: Card(role: "Merlin"), title: "Player 1")
        CardView(card: Card(role: "Merlin", isPlayer: true))
    }
=======
    CardView(card: Card(title: "Knight", color: .blue))
>>>>>>> d3b9658cd6a86ce4e8fe5956bcc3057967a107d8
}
