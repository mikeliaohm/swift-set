//
//  Card.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct Card {
    private var cardNumber = CardAttribute.choiceOne
    private var cardColor = CardAttribute.choiceOne
    private var cardShade = CardAttribute.choiceOne
    private var cardShape = CardAttribute.choiceOne
    
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

enum CardAttribute {
    case choiceOne
    case choiceTwo
    case choiceThree
}
