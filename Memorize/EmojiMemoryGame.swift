//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jake Ledner on 5/17/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    private(set) var theme: MemoryGame<String>.Theme
    
    init() {
        let chosenTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(for: chosenTheme)
        theme = chosenTheme
    }

    func resetGame() {
        var newTheme = EmojiMemoryGame.themes.randomElement()!
        newTheme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(for: newTheme)
        theme = newTheme
        shuffle()
    }
    
    static let themes = 
    [MemoryGame<String>.Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "💀", "☠️", "😱", "😈", "🙀"], numberOfPairs: 8, color: .orange),
     MemoryGame<String>.Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🏓", "🥊", "⛷️"], numberOfPairs: 8, color: .green),
     MemoryGame<String>.Theme(name: "Countries", emojis: ["🇺🇸", "🇯🇵", "🇫🇷", "🇨🇦", "🇧🇷", "🇩🇪", "🇰🇷", "🇮🇹"], numberOfPairs: 6, color: .blue),
     MemoryGame<String>.Theme(name: "Juliette", emojis: ["🥺", "🌯", "🪼", "🥳", "🇨🇺", "🇪🇸", "🇮🇹", "🐶", "💕", "🤍", "🍝", "🍜"], numberOfPairs: 10, color: .purple),
     MemoryGame<String>.Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄"], numberOfPairs: 10, color: .cyan),
     MemoryGame<String>.Theme(name: "Food", emojis: ["🍕", "🍔", "🍟", "🌭", "🍿", "🥪", "🌮", "🌯", "🥗", "🍣", "🍩", "🍪", "🍰", "🧁", "🍦", "🥤"], numberOfPairs: 10, color: .red)
    ]
    
    private static func createMemoryGame(for theme: MemoryGame<String>.Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: theme.numberOfPairs){
            pairIndex in theme.emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(with card: MemoryGame<String>.Card){
        model.choose(with: card)
    }
}


//extension MemoryGame<String>.Theme {
//    var themeColor: Color {
//        switch color.lowercased() {
//        case "red": .red
//        case "blue": .blue
//        case "green": .green
//        case "orange": .orange
//        case "pink": .pink
//        case "purple": .purple
//        default: .gray
//        }
//    }
//}
