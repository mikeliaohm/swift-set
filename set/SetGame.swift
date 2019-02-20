//
//  SetGame.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/19.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct SetGame {
    
    var cards = [Card]()

    init() {
//        initiate 81 cards in the set game
        for _ in 1...81 {
            let card = Card()
            cards += [card]
        }
        cards = cards.shuffled()
    }
    
}

