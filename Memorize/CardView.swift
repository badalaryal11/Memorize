//
//  CardViiew.swift
//  Memorize
//
//  Created by Badal  Aryal on 12/08/2024.
//

import SwiftUI

struct CardView: View{
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    
    var body: some View{
        
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Path { p in
                    p.move(to: .zero)
                    p.addLine(to: CGPoint(x: 50, y: 200))
                }
                .stroke(lineWidth: 6)
                Pie(endAngle: .degrees(240))
                
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                            .minimumScaleFactor(Constants.FontSize.scaleFactor)
                            .multilineTextAlignment(.center)
                            .aspectRatio(1, contentMode: .fit)
                            .padding(Constants.Pie.inset)
                    )
                    .padding(Constants.inset)
                
            }
            .opacity(card.isFaceUp ? 1: 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card (isFaceUp: true ,content: "X", id: "test1"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card (content: "X", id: "test1"))
            }
            HStack{
                CardView(Card (isFaceUp: true ,isMatched: true,content: "This is a very long string and hope it fits", id: "test1"))
                CardView(Card (isMatched: true ,content: "X", id: "test1"))
                
            }
        }
        .padding()
        
    }
}
