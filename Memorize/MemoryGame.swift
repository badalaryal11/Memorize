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
    
    var indexOfTheOneAndOnlyFaceupCard: Int? {
        // computed property
        get {  cards.indices.filter{ index in cards[index].isFaceUp}.only }
            // look and find if there is one faceup card
        set {  cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
        //for each card indicies we are going to set value that is either be that we set as or false
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id }){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceupCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        }
                } else {
                    indexOfTheOneAndOnlyFaceupCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            
        }
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

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
