//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Badal  Aryal on 27/05/2024.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
