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
        print("test \(game.cards[0])")
    }
}


