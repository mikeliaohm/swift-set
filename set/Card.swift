//
//  Card.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct Card {
    
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
    case color(AttributeOption)
    case number(AttributeOption)
    case shade(AttributeOption)
    case shape(AttributeOption)
    
    enum AttributeOption: CaseIterable {
        case choiceOne
        case choiceTwo
        case choiceThree
    }
    
    static var allCases: [[CardAttribute]] {
        var caseArray = [[CardAttribute]]()
        for colorAttribute in AttributeOption.allCases.map(CardAttribute.color) {
            for numberAttribute in AttributeOption.allCases.map(CardAttribute.number) {
                for shadeAttribute in AttributeOption.allCases.map(CardAttribute.shade) {
                    for shapeAttribute in AttributeOption.allCases.map(CardAttribute.shape) {
                        caseArray.append([colorAttribute, numberAttribute, shadeAttribute, shapeAttribute])
                    }
                }

            }
        }
        return caseArray
    }
    
}

