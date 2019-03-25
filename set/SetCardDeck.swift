//
//  SetCardDeck.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/3/25.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct SetCardDeck {
    private(set) var cards = [Card]()
    
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
    }
    
    mutating func dealCards(with numberOfCards: Int) -> [Card] {
        // check if playedCards contain any matchedCards. If so replace those cards with cards to deal
        
        let cardsDealt = Array(cards[0...numberOfCards-1])
        
        return cardsDealt
    }
    
}
