//
//  BlackShadowText.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-04.
//

import SwiftUI

struct BlackShadowText: View {
    let text: String
    let width: CGFloat

    var body: some View {
            ZStack (alignment: .topLeading) {
                Text(text)
                    .padding()
                    .frame(maxWidth: width)
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
    }
}
