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
        ZStack {
            fullScreenBackground
            VStack(spacing: 12) {
                topNavBar
                title
                cards
                    .animation(.snappy, value: viewModel.cards)
                score
            }
            .padding()
        }
    }
    
    private var fullScreenBackground: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(
                ImagePaint(image: Image("food"), scale: 1.0).opacity(0.15)
            )
            .ignoresSafeArea()
    }
    
    private var topNavBar: some View {
        HStack{
            newGameButtonComponent
            Spacer()
            themeComponent
        }
        .padding(.horizontal)
        .padding(.top, 10)

    }
    
    private var newGameButtonComponent: some View {
        Button("New Game"){
            viewModel.resetGame()
        }
        .foregroundColor(.blue)
        .font(.system(size: 18, weight: .semibold))
    }
    
    private var themeComponent: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(viewModel.theme.themeColor) // Or use theme color
                    .frame(width: 50, height: 50)
                viewModel.theme.themeIcon
            }
            VStack(alignment: .leading, spacing: 2){
                
                Text("Theme")
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.8))
                Text(viewModel.theme.name)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(.black.opacity(0.7))
        .clipShape(Capsule())
        .opacity(0.9)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var title: some View {
        VStack {
            ZStack {
                Text("Memorize!")
                    .font(.system(size: 40, weight: .black, design: .serif))
                    .foregroundColor(.clear) // Make the fill invisible
                    .overlay(
                        Text("Memorize!")
                            .font(.system(size: 40, weight: .black, design: .serif))
                            .foregroundColor(.black) // Stroke color
                    )
                    .overlay(
                        Text("Memorize!")
                            .font(.system(size: 40, weight: .black, design: .serif))
                            .foregroundStyle(LinearGradient(colors: [.blue, .teal], startPoint: .topLeading, endPoint: .bottomTrailing))
                    )
                    .padding(2)
            }
        }
    }
    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(with: card)
                }
        }
        .foregroundColor(viewModel.theme.themeColor)
    }
    
    private var score: some View {
        ZStack{
            Spacer()
            HStack{
                Spacer()
                Text("Score")
                    .bold()
                    .padding(.vertical, 20)
                Spacer()
                Spacer()
                Text("\(viewModel.score)")
                    .frame(minWidth: 30)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .background(.white)
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                Spacer()
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10)
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
            .font(.title)
            }
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
