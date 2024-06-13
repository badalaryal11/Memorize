//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Badal  Aryal on 13/06/2024.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
