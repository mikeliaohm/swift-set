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
    private var color, number, shade, shape: CardAttribute
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
//        assert that only 81 cards are allowed to be init'ed
        assert(identifierFactory <= 81, "Card init exceeding range, only 81 cards are available")
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
        
        let attributeAllCases = CardAttribute.allCases
        let attributeIdentifier = self.identifier - 1
        self.color = attributeAllCases[attributeIdentifier][0]
        self.number = attributeAllCases[attributeIdentifier][1]
        self.shade = attributeAllCases[attributeIdentifier][2]
        self.shape = attributeAllCases[attributeIdentifier][3]
    }
}

enum CardAttribute: Equatable {
    
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

