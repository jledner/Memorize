//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jake Ledner on 5/17/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    
    @Published private var selectedTheme = "Halloween"
    
    var theme: String {
        get { selectedTheme }
        set {
            selectedTheme = newValue
            resetGameWithTheme(newValue)
        }
    }
    
    static let themes = Array(emojisByName.keys)

    private static let emojisByName: [String: [String]] = [
        "Halloween": ["👻", "🎃", "🕷️", "💀", "☠️", "😱", "😈", "🙀"],
        "Sports": ["⚽️", "🏀", "🏈", "🎾", "🏐", "🏓", "🥊", "⛷️"],
        "Countries": ["🇺🇸", "🇯🇵", "🇫🇷", "🇨🇦", "🇧🇷", "🇩🇪", "🇰🇷", "🇮🇹"],
        "Juliette": ["🥺", "🌯", "🪼", "🥳", "🇨🇺", "🇪🇸", "🇮🇹", "🐶", "💕", "🤍", "🍝", "🍜"]
    ]

    
    private static func createMemoryGame(for theme: String) -> MemoryGame<String> {
        let emojis = emojisForTheme(theme)
        
        return MemoryGame(numberOfPairsOfCards: min(16, emojis.count)) {
            pairIndex in emojis[pairIndex]
        }
    }
    
    private static func emojisForTheme(_ theme: String) -> [String] {
        emojisByName[theme] ?? ["❓"]
    }

    
    func resetGameWithTheme(_ theme: String) {
        model = EmojiMemoryGame.createMemoryGame(for: theme)
    }
        
    @Published private var model = createMemoryGame(for: "Halloween")
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
}
