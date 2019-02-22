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
    private var choosenCards = [Card]()
    
    mutating func chooseCard(at index: Int) {
        choosenCards.append(cards[index])
        if choosenCards.count == 3 {
            checkSet(of: choosenCards)
            choosenCards = []
        }
    }
    
    mutating func checkSet(of cards: [Card]) {

    }
    
    init() {
//        initiate 81 cards in the set game
        for _ in 1...81 {
            let card = Card()
            cards += [card]
        }
        cards = cards.shuffled()
    }
    
}

