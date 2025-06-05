//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Jake Ledner on 5/17/25.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var seen: Array<CardContent>
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        seen = []
        // add numberPairsOfCards x 2 cards
        
        for pairIndex in 0..<max(0, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter{ index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(with card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id
        }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    let chosenCardContent = cards[chosenIndex].content
                    let otherCardContent = cards[potentialMatchIndex].content
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                    else{
                        // check if cards at the potential match index && chosen index are already in the array, and if so, increment score, otherwise add them using code below
                        if seen.contains(chosenCardContent){
                            score -= 1
                        }
                        else {
                            seen.append(chosenCardContent)
                        }
                        if seen.contains(otherCardContent){
                            score -= 1
                        }
                        else {
                            seen.append(otherCardContent)
                        }
                    }
                } else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                    print(seen)
                }
                cards[chosenIndex].isFaceUp = true
                print(score)
            }
        }
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            } 
        }
        return nil
    }
    
    mutating func shuffle(){
        cards = cards.shuffled()
    }
    
    mutating func resetScore(){
        score = 0
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "" )"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
