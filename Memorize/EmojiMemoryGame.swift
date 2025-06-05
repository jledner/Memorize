//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jake Ledner on 5/17/25.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme
    
    init() {
        let chosenTheme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(for: chosenTheme)
        theme = chosenTheme
        shuffle()
    }
    
    private static let themes = 
    [Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "💀", "☠️", "😱", "😈", "🙀"], numberOfPairs: 8, color: "orange", icon: "moon"),
     Theme(name: "Sports", emojis: ["⚽️", "🏀", "🏈", "🎾", "🏐", "🏓", "🥊", "⛷️"], numberOfPairs: 8, color: "green", icon: "flame"),
     Theme(name: "Countries", emojis: ["🇺🇸", "🇯🇵", "🇫🇷", "🇨🇦", "🇧🇷", "🇩🇪", "🇰🇷", "🇮🇹"], numberOfPairs: 6, color: "blue", icon: "star"),
     Theme(name: "Juliette", emojis: ["🥺", "🌯", "🪼", "🥳", "🇨🇺", "🇪🇸", "🇮🇹", "🐶", "💕", "🤍", "🍝", "🍜"], numberOfPairs: 10, color: "purple", icon: "heart"),
     Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄"], numberOfPairs: 10, color: "cyan", icon: "dog"),
     Theme(name: "Food", emojis: ["🍕", "🍔", "🍟", "🌭", "🍿", "🥪", "🌮", "🌯", "🥗", "🍣", "🍩", "🍪", "🍰", "🧁", "🍦", "🥤"], numberOfPairs: 10, color: "red", icon: "fork")
    ]
    
    private static func createMemoryGame(for theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: theme.numberOfPairs){
            pairIndex in theme.emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(with card: MemoryGame<String>.Card) {
        model.choose(with: card)
    }
    
    func resetGame() {
        var newTheme = EmojiMemoryGame.themes.randomElement()!
        newTheme.emojis.shuffle()
        model = EmojiMemoryGame.createMemoryGame(for: newTheme)
        theme = newTheme
        model.resetScore()
        shuffle()
    }
}


extension Theme {
    var themeColor: Color {
        switch color.lowercased() {
        case "red": .red
        case "blue": .blue
        case "green": .green
        case "orange": .orange
        case "pink": .pink
        case "purple": .purple
        case "cyan" : .cyan
        default: .gray
        }
    }
}

extension Theme {
    var themeIcon: Image {
        switch icon.lowercased() {
        case "star": return Image(systemName: "star.fill")
        case "flame": return Image(systemName: "flame.fill")           // 🔥
        case "drop": return Image(systemName: "drop.fill")           // 💧
        case "leaf": return Image(systemName: "leaf.fill")          // 🍃
        case "sun": return Image(systemName: "sun.max.fill")      // ☀️
        case "heart": return Image(systemName: "heart.fill")          // ❤️
        case "moon": return Image(systemName: "moon.fill")         // 🌙
        case "cloud": return Image(systemName: "cloud.fill")          // ☁️
        case "fork": return Image(systemName: "fork.knife")          // 🍴
        case "dog": return Image(systemName: "dog.fill")             // 🐕
        default: return Image(systemName: "questionmark.circle.fill") // ❓
        }
    }
}
