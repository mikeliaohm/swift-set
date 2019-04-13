//
//  SetCardDeck.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/3/25.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct SetCardGame {
    
    private(set) var cards = [Card](), matchedCards = [Card](), playedCards = [Card]()
    private var dealtCardNumber = 0
    
    mutating func evaluateSet(of chosenCards: [Card]) -> Bool {
        if checkSet(of: chosenCards) {
            matchedCards += chosenCards
            playedCards = playedCards.filter { !chosenCards.contains($0) }
            print("played card number: \(playedCards.count)")
            return true
        } else {
            return false
        }
    }
    
    private mutating func checkSet(of chosenCards: [Card]) -> Bool {
        //  IDEA: use Set(Array) to check whether arrays formed from card's four attribute have all equal elements or all unqiue elements. Set(Array).count == 1 or Set(Array).count == 3
//        let colorAttribute = chosenCards.map { $0.color }
//        let numberAttribute = chosenCards.map { $0.number }
//        let shadeAttribute = chosenCards.map { $0.shade }
//        let shapeAttribute = chosenCards.map { $0.shape }
//        return Set(colorAttribute).setFormed &&
//            Set(numberAttribute).setFormed &&
//            Set(shadeAttribute).setFormed &&
//            Set(shapeAttribute).setFormed
        return true
    }
    
    mutating func dealCards(with numberOfCards: Int) {
        // check if playedCards contain any matchedCards. If so replace those cards with cards to deal
        
        let cardsDealt = Array(cards[dealtCardNumber...(dealtCardNumber + numberOfCards - 1)])
        dealtCardNumber += numberOfCards
        playedCards += cardsDealt
    }
    
    init() {
        for color in Card.Attributes.all {
            for number in Card.Attributes.all {
                for shade in Card.Attributes.all {
                    for shape in Card.Attributes.all {
                        cards.append(Card(color: color, number: number, shade: shade, shape: shape))
                    }
                }
            }
        }
        cards = cards.shuffled()
        dealCards(with: 12)
    }
}

// extend protocol
extension Collection {
    var setFormed: Bool {
        return count == 1 || count == 3
    }
}
