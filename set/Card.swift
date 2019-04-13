//
//  Card.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import Foundation

struct Card: Equatable {
//    static func == (lhs: Card, rhs: Card) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
    
    let color, number, shade, shape: Attributes
    
    enum Attributes: String, CustomStringConvertible {
        var description: String { return rawValue }
        
        case choiceOne = "one"
        case choiceTwo = "two"
        case choiceThree = "three"
        
        static var all = [Attributes.choiceOne, .choiceTwo, .choiceThree]
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

