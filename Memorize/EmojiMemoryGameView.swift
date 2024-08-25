//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Badal  Aryal on 27/05/2024.
//


import SwiftUI

struct EmojiMemoryGameView: View {
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame  // point to our viewmodel
    //@ObservedObject says if this thing says something has changed redraw me.
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
            HStack {
                score
                Spacer()
                deck
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation{
                viewModel.shuffle() // intent of user
            }
        }
    }

    private var cards: some View {
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .onTapGesture {
                        choose(card)
                    }
                    .transition(.offset(
                        x:CGFloat.random(in: -1000...1000),
                        y:CGFloat.random(in: -1000...1000)
                    ))
            }
        }
        
    }
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter{ !isDealt($0)}
    }
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .transition(.offset(
                        x:CGFloat.random(in: -1000...1000),
                        y:CGFloat.random(in: -1000...1000)
                    ))
                
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            // deal the cards
            withAnimation(.easeInOut(duration: 2)) {
                for card in viewModel.cards {
                    dealt.insert(card.id)
                }
            }
            
        }
    }
    private let deckWidth: CGFloat = 50
    
    private func choose(_ card: Card) {
        withAnimation {
            //update var everytime score changes
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, card.id)
        }
    }
    //tuple to get track of lastscore change
    @State private var lastScoreChange = (0, causedByCardId:"")
        
    
    private func scoreChange(causedBy card: Card) -> Int {
        //implent lastscore change
        // get values out of tuple
        let (amount, id) = lastScoreChange
        return card.id == id ? amount : 0
        
    }
}



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame()) // set var viewmodel
    }
}

