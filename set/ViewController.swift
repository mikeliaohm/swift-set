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
    private let cardColor = [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    private let cardShape = ["●", "▲", "■"]
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func chooseCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons.")
        }
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

            switch card?.cardAttribute.color {
            case .choiceOne?:
                    button.backgroundColor = cardColor[0]
            case .choiceTwo?:
                    button.backgroundColor = cardColor[1]
            case .choiceThree?:
                    button.backgroundColor = cardColor[2]
            case .none:
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
            
            switch card?.cardAttribute.shape {
//                var buttonShape: String?
                case .choiceOne?:
//                buttonShape = cardShape[0]
                button.setTitle(cardShape[0], for: UIControl.State.normal)
                case .choiceTwo?:
                button.setTitle(cardShape[1], for: UIControl.State.normal)
                case .choiceThree?:
                button.setTitle(cardShape[2], for: UIControl.State.normal)
                default:
                button.setTitle("", for: UIControl.State.normal)
            }
            
            let attributes: [NSAttributedString.Key:Any] = [
                .strokeWidth : 5.0,
                .strokeColor : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            ]
            let attributedString = NSAttributedString(string: "tests", attributes: attributes)
            button.setAttributedTitle(attributedString, for: UIControl.State.normal)
//            button.backgroundColor = (card != nil) ? #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
        }
    }

    
    
}



