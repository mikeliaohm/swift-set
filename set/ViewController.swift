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
    private var chosenButtons = [UIButton]()
    private var setMatched = false
    private let cardColor = [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)]
    private let cardShape = ["●", "▲", "■"]
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var dealButton: UIButton! {
        didSet {
            dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
        }
    }
    @IBOutlet weak var matchResult: UILabel!
    
    @IBAction func chooseCard(_ sender: UIButton) {
        if setMatched {
            updateViewFromModel()
            setMatched = false
        }
        let cardNumber = cardButtons.index(of: sender)
//        user can only select cards that are on display
        if (game.playedCards[cardNumber!] != nil) {
//            user deselect card when the same card is selected again
            if chosenButtons.contains(sender) {
                chosenButtons = chosenButtons.filter { $0 != sender }
            } else {
                chosenButtons.append(sender)
//                game.evaluateSet is called when user selects 3 cards
                if chosenButtons.count == 3 {
                    var chosenCards = [Card]()
                    for button in chosenButtons {
                        let cardNumber = cardButtons.index(of: button)
                        chosenCards.append(game.playedCards[cardNumber!]!)
                    }
                    setMatched = game.evaluateSet(of: chosenCards)
                    if setMatched {
                        matchResult.text = "Matched!"
                        dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
                    } else {
                        matchResult.text = "Mismatched!"
                    }
                }
            }
        }
       updateChosenCards(with: chosenButtons.count)
    }
    
    private func updateChosenCards(with numberOfChosenButtons: Int) {
        for card in cardButtons {
            if chosenButtons.contains(card) {
                card.layer.borderWidth = 3.0
                card.layer.borderColor = UIColor.blue.cgColor
            } else {
                card.layer.borderWidth = 1.0
                card.layer.borderColor = nil
            }
        }
        if numberOfChosenButtons == 3 {
            chosenButtons = [UIButton]()
        } else {
            matchResult.text = ""
        }
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        game = SetGame()
        updateViewFromModel()
    }
    
    @IBAction func dealCard(_ sender: UIButton) {
        let numberOfFaceUpCards = game.playedCards.filter { $0 != nil }.count
        if numberOfFaceUpCards <= 21 {
            if game.cards.count != 0 {
                game.dealCards(with: 3)
                updateViewFromModel()
                dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
            } else {
                dealButton.setTitle("Cards empty", for: UIControl.State.normal)
            }
            if numberOfFaceUpCards == 21 {
                dealButton.setTitle("Cards full (\(game.cards.count))", for: UIControl.State.normal)
            }
        }
    }
    
//    private func disableDealButton() {
//    }
    
    private func updateViewFromModel() {
        var displayShape: String
        var displayFill: Float
        var displayShade = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        var displayColor: UIColor
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.playedCards[index]

            switch card?.cardAttribute.color {
            case .choiceOne?:
                displayColor = cardColor[0]
//                    button.backgroundColor = cardColor[0]
            case .choiceTwo?:
                displayColor = cardColor[1]
//                    button.backgroundColor = cardColor[1]
            case .choiceThree?:
                displayColor = cardColor[2]
//                    button.backgroundColor = cardColor[2]
            case .none:
                displayColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
            
            switch card?.cardAttribute.shape {
            case .choiceOne?:
                displayShape = cardShape[0]
            case .choiceTwo?:
                displayShape = cardShape[1]
            case .choiceThree?:
                displayShape = cardShape[2]
            default:
                displayShape = ""
            }
            
            switch card?.cardAttribute.shade {
            case .choiceOne?:
                displayFill = -1.0
                displayShade = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15)
            case .choiceTwo?:
                displayFill = -1.0
            case .choiceThree?:
                displayFill = 5.0
            default:
                displayFill = 5.0
            }
            
            let attributes: [NSAttributedString.Key:Any] = [
                .strokeColor : displayColor,
                .strokeWidth : displayFill,
                .foregroundColor: displayShade
            ]
            let attributedString = NSAttributedString(string: displayShape, attributes: attributes)
            button.setAttributedTitle(attributedString, for: UIControl.State.normal)
//            button.backgroundColor = (card != nil) ? #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
        }
    }
}



