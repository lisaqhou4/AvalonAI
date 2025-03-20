//
//  ChatView.swift
//  AvalonAI
//
//  Created by Rachel on 2025-04-02.
//
import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))    // top point
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom right
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // bottom left
        path.closeSubpath()
        return path
    }
}


struct ChatBubbleView: View {
    let index: Int
    let message: String
    let chatTailOffset: CGFloat

    var body: some View {
        ZStack (alignment: .topLeading){
            GeometryReader { geo in
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: CGFloat(index) * (50 + 16)) // vertical alignment

                        HStack(alignment: .top, spacing: 8) {
                            Spacer()
                                .frame(width: 60) // space for the avatar

                            Text(message)
                                .padding()
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(16)
                                .foregroundColor(.black)
                                .frame(maxWidth: geo.size.width - 70, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                    .padding(.top, 8)
                }
            }
        }
        
        
//        HStack(alignment: .top, spacing: 0) {
//            Triangle()
//                .fill(Color.white.opacity(0.5))
//                .frame(width: 17, height: 20)
//                .rotationEffect(.degrees(-90)) // points left
//                .offset(x: 0, y: 15)
//            VStack {
//                ScrollView {
//                    Text(message)
//                        .padding()
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, alignment: .topLeading)
//                }
//                .background(Color.white.opacity(0.5))
//                .cornerRadius(16)
//                .frame(maxWidth: 250, maxHeight: 200, alignment: .topLeading)
//                .fixedSize(horizontal: false, vertical: true)
//            }
//        }
        
    }
}

#Preview {
    ZStack {
        Rectangle().background(Color.black)
            .scaledToFill()
            .ignoresSafeArea()
        // index 1: []
        HStack (alignment: .top) {
            ChatBubbleView(index: 0,
                     message: "Hello World",
                     chatTailOffset: 20)
    //        ChatBubbleView(index: 0,
    //                 message: "Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa Hello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaaHello World aaaaaaaaaaaaaaa aaaaaaaaaaa  aaaaa ",
    //                 chatTailOffset: 50)
        }
        
    }
}

