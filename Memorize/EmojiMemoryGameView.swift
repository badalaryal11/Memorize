//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Badal  Aryal on 27/05/2024.
//


import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame  // point to our viewmodel
    //@ObservedObject says if this thing says something has changed redraw me.
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(viewModel.color)
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle() // intent of user
            }
        }
        .padding()
    }
    
    private var cards: some View {
        
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            
            return CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                    
                }
        }
        
        
        .foregroundColor(Color.green)
    }
    
    
    
    
    
    
}



struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame()) // set var viewmodel
    }
}

