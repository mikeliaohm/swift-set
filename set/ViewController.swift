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

    private lazy var game = SetGame()
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func chooseCard(_ sender: UIButton) {
        updateViewFromModel()
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.playedCards[index]

            button.backgroundColor = (card != nil) ? #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
        }
    }

    
    
}



