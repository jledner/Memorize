//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Jake Ledner on 4/24/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            ZStack {
                Text("Memorize!")
                    .font(.system(size: 40, weight: .black, design: .rounded))
                    .foregroundColor(.clear) // Make the fill invisible
                    .overlay(
                        Text("Memorize!")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundColor(.black) // Stroke color
                    )
                    .overlay(
                        Text("Memorize!")
                            .font(.system(size: 40, weight: .black, design: .rounded))
                            .foregroundStyle(LinearGradient(colors: [.blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
            }
            Picker("Theme", selection: $viewModel.theme) {
                ForEach(EmojiMemoryGame.themes, id: \.self) { theme in
                    HStack {
                        Image(systemName: EmojiMemoryGame.iconForTheme(theme))
                        Spacer().frame(width: 8)
                        Text(theme)
                            .foregroundStyle(Color.white)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                    }
                }
            }
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
            
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            VStack{
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(with: card)
                    }
            }
        }
        .foregroundColor(Color.orange)
    }
}


struct CardView: View{
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider{
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
