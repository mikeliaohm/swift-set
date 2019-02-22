//
//  ViewController.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var cardIdentifier: UILabel! {
        didSet {
            updateCardIdentifier()
        }
    }
    
    private func updateCardIdentifier() {
        var game = SetGame()
//        var caseText: String
//        switch game[1].cardNumber {
//        case .choiceOne:
//            caseText = "one"
//        case .choiceTwo:
//            caseText = "two"
//        case .choiceThree:
//            caseText = "three"
//        }
//
//        cardIdentifier.text = caseText
        print("first card: \(game.cards[0])")
        let attribute = game.cards[0].cardAttribute
        print("first card attribute: \(Set([attribute.color, attribute.number, attribute.shape, attribute.shade]))")
//        print("set testing: \(Set(game.cards[0].cardAttribute))")
        
//        print("cases: \(cases)")
//        print("cases: \(cases[80][0])")
//        print("case count: \(cases.count)")
//        let attribute = CardAttribute.color(.choiceThree)
//        let attribute1 = cases[80][0]
//        let result = attribute1 == attribute
//        print("\(result)")
//        var attribute3: CardAttribute
//        attribute3(.color) = attribute1
//        let attribute2 = CardAttribute(.color(.choiceOne), .number(.choiceOne), .shade(.choiceOne), .shape(.choiceOne))
//        print("\(attribute2)")
    

    }
    
}


