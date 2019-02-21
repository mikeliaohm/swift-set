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
    private var faceUpCard = [Int]()
    
    mutating func chooseCard(at index: Int) {
        faceUpCard.append(index)
        if faceUpCard.count == 3 {
            faceUpCard = [Int]()
        } else {
            
        }
        
        
        
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

