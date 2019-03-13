//
//  SetGame.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/19.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct SetGame {
    
    private(set) var cards = [Card](), chosenCards = [Card](), matchedCards = [Card](), playedCards = [Card?](repeating: nil, count: 24)
    
    mutating func evaluateSet(of chosenCards: [Card]) -> Bool {
        print("============================")
        print("chosen cards: \(chosenCards)")
        print("============================")
        if checkSet(of: chosenCards) {
            matchedCards += chosenCards
            for card in chosenCards {
                let cardSpot = playedCards.index(of: card)!
                playedCards[cardSpot] = nil
            }
            return true
        } else {
            return false
        }
    }
    
    mutating func dealCards(with numberOfCards: Int) {
        // check if playedCards contain any matchedCards. If so replace those cards with cards to deal
        assert(playedCards.filter({ $0 != nil }).count <= 24, "You can not have more than 24 cards played simuteneously.")
        
        let cardsDealt = Array(cards[0...numberOfCards-1])
            // find the chosenCards in playedCards and replace that with cardsDealt
        for card in cardsDealt {
            let cardSpot = playedCards.firstIndex{ $0 == nil }
            playedCards[cardSpot!] = card
        }
        cards = Array(cards[numberOfCards...])
        print("played cards count: \(playedCards.count)")
        print("cards left: \(cards.count)")
    }
    
    private mutating func checkSet(of chosenCards: [Card]) -> Bool {
        //  IDEA: use Set(Array) to check whether arrays formed from card's four attribute have all equal elements or all unqiue elements. Set(Array).count == 1 or Set(Array).count == 3
        let colorAttribute = chosenCards.map { $0.cardAttribute.color }
        let numberAttribute = chosenCards.map { $0.cardAttribute.number }
        let shadeAttribute = chosenCards.map { $0.cardAttribute.shade }
        let shapeAttribute = chosenCards.map { $0.cardAttribute.shape }
        return Set(colorAttribute).setFormed &&
            Set(numberAttribute).setFormed &&
            Set(shadeAttribute).setFormed &&
            Set(shapeAttribute).setFormed
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
        return count == 1 || count == 3
    }
}
