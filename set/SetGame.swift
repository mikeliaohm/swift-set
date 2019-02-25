//
//  SetGame.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/19.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct SetGame {
    
    private(set) var cards = [Card]()
    private(set) var chosenCards = [Card](), matchedCards = [Card](), playedCards = [Card?]()
    private(set) var matchedSet = false
    
    mutating func chooseCard(at index: Int) {
        chosenCards.append(cards[index])
        if chosenCards.count == 3 {
            if checkSet(of: chosenCards) {
                matchedCards += chosenCards
                matchedSet = true
            }
        }
    }
    
    mutating func updateCard() {
        chosenCards = []
    }
    
    mutating func dealCards(with numberOfCards: Int) {
        // check if playedCards contain any matchedCards. If so replace those cards with cards to deal
        let cardsDealt = Array(cards[0...numberOfCards-1])
        if matchedSet {
            // find the chosenCards in playedCards and replace that with cardsDealt
        } else {
            playedCards += cardsDealt
        }
        assert(playedCards.count <= 24, "You can not have more than 24 cards played simuteneously.")
        cards = Array(cards[numberOfCards...])
    }
    
    private mutating func checkSet(of chosenCards: [Card]) -> Bool {
        //  IDEA: use Set(Array) to check whether arrays formed from card's four attribute have all equal elements or all unqiue elements. Set(Array).count == 1 or Set(Array).count == 3
        let colorAttribute = chosenCards.map { $0.cardAttribute.color }
        let numberAttribute = chosenCards.map { $0.cardAttribute.number }
        let shadeAttribute = chosenCards.map { $0.cardAttribute.shade }
        let shapeAttribute = chosenCards.map { $0.cardAttribute.shape }
        if Set(colorAttribute).setFormed &&
            Set(numberAttribute).setFormed &&
            Set(shadeAttribute).setFormed &&
            Set(shapeAttribute).setFormed {
            return true
        } else {
            return false
        }
    }
    
    init() {
        // initiate 81 cards in the set game
        for _ in 1...81 {
            let card = Card()
            cards += [card]
        }
        cards = cards.shuffled()
        dealCards(with: 12)
    }
    
}

// extend protocol
extension Collection {
    var setFormed: Bool {
        if count == 1 || count == 3 {
            return true
        } else {
            return false
        }
    }
}
