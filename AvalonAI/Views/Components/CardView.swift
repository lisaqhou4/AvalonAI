import SwiftUI

struct CardView: View {
    let card: Card

    var body: some View {
        VStack {
            Text(card.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: 100, height: 150)
        .background(card.color)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    CardView(card: Card(title: "Knight", color: .blue))
}
