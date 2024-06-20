//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Badal  Aryal on 13/06/2024.
// ViewModel: understand the model and talk to it.

import SwiftUI




class EmojiMemoryGame: ObservableObject { // reactive UI
    private static let emojis = ["👻", "🎃", "🕷", "👹", "👹", "😍", "🤑", "😡", "😃", "😛","😜","🤡","🇳🇵","💀","🤖","🌏"]
    
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(numberOfPairsOfCards: 18) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
    
    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        
        
    }
    // intent function: Users intent to choose the function
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
