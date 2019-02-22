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
    private var choosenCard = [Card]()
    
    mutating func chooseCard(at index: Int) {
        choosenCard.append(cards[index])
        if choosenCard.count == 3 {
            checkSet(of: choosenCard)
            choosenCard = []
        }
    }
    
    mutating func checkSet(of cards: [Card]) {
        let colorArray = cards.map { $0.color }
        let numberArray = cards.map { $0.number }
        let shadeArray = cards.map { $0.shade }
        let shapeArray = cards.map { $0.shape }
        let result = colorArray.dropFirst().allSatisfy({ $0 == colorArray.first })
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

