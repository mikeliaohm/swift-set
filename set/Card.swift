//
//  Card.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    private var identifier: Int
    private(set) var cardAttribute: CardAttribute
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
//        assert that only 81 cards are allowed to be init'ed
        if identifierFactory == 82 {
            identifierFactory = 1
        }
        assert(identifierFactory <= 81, "Card init exceeding range, only 81 cards are available")
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        self.cardAttribute = CardAttribute(at: self.identifier - 1)
    }
}

struct CardAttribute {
    
    private(set) var color, number, shade, shape: AttributeOption
    
    enum AttributeOption: CaseIterable {
        case choiceOne
        case choiceTwo
        case choiceThree
    }
    
    static var allCases: [[AttributeOption]] {
        var caseArray = [[AttributeOption]]()
        for colorAttribute in AttributeOption.allCases {
            for numberAttribute in AttributeOption.allCases {
                for shadeAttribute in AttributeOption.allCases {
                    for shapeAttribute in AttributeOption.allCases {
                        caseArray.append([colorAttribute, numberAttribute, shadeAttribute, shapeAttribute])
                    }
                }
            }
        }
        return caseArray
    }
    
    init(at index: Int) {
        let allCases = CardAttribute.allCases
        self.color = allCases[index][0]
        self.number = allCases[index][1]
        self.shade = allCases[index][2]
        self.shape = allCases[index][3]
    }
    
}

