//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Badal  Aryal on 13/06/2024.
// ViewModel: understand the model and talk to it : view's butler

import SwiftUI




class EmojiMemoryGame: ObservableObject { // ObservableObject: reactive UI
    // classes get a free initializers but their initializers have no arguments
    typealias Card = MemoryGame<String>.Card
    //let skyBlue = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    private static let emojis = ["👻", "🎃", "🕷", "👹", "😡", "😃", "😜","🤡","🇳🇵","💀","🤖","🌏"] // static: make emoji global but namespace it inside the class  and private make it only for us to use
    
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(numberOfPairsOfCards: 15) { pairIndex in
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
        }
    }
    
    
    
    @Published private var model = createMemoryGame() // @Published on var says if this var changes something has changed
        // private means view cannot see it but can cause something to change 
    let linkColor = Color(uiColor: .link)

    var cards: Array<Card> {
         model.cards
    }
    
    var color: Color {
        .purple
    }
    
    var score: Int {
        model.score
    }
    //MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        
        
    }
    // intent function: Users intent to choose the function
    func choose(_ card: Card) {
        model.choose(card)
    }
}


