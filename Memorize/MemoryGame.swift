//
//  MemorizeGame.swift
//  Memorize
//  Model
//  Created by Badal  Aryal on 13/06/2024.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> // private makes 'acess control' limit to this class only and set only let setting the variable is private but looking at it is allowed.
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [] // empty array
        
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_ card: Card) {
        let chosenIndex = index(of:card)
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id{
                return index
            }
        }
        return 0    // FIXME: bogus!
    }
    
    
    mutating func shuffle() { // Any  function that modifies model have to be marked mutating
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
       
        
       
        
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            return "\(id) \(content) \(isFaceUp ? "up": "down")\(isMatched ? " matched" : "")"
        }
    }
}
