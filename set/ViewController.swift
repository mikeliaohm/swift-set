//
//  ViewController.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/2/17.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var setMatched = false
    private var game = SetCardGame()
    private var tappedCardIndices = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var gridFrameView: GridFrameView! {
        didSet {
            let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(startGame))
            swipeDown.direction = [.down]
            gridFrameView.addGestureRecognizer(swipeDown)
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(cheat))
            swipeLeft.direction = [.left, .right]
            gridFrameView.addGestureRecognizer(swipeLeft)
        }
    }
    
    @objc func startGame() {
        if gridFrameView.numberOfPlayedCards != 0 {
            if game.cardsLeft {
                game.dealCards(with: 3)
            } else {
                return
            }
        }
        updateUI()
    }
    
    @objc func tapCard(sender: UITapGestureRecognizer) {
        if let tappedIndex = gridFrameView.setCardViews.index(of: sender.view as! SetCardView) {
            if tappedCardIndices.contains(tappedIndex) {
                tappedCardIndices = tappedCardIndices.filter { $0 != tappedIndex }
            } else {
                tappedCardIndices.append(tappedIndex)
            }
        }
        evaluateTappedCards()
    }

    @objc func cheat() {
        let pairs = game.cheat()
        print("swipe for cheat: \(pairs.count)")
    }
    
    private func evaluateTappedCards() {
        if setMatched {
            tappedCardIndices.removeAll()
            updateUI()
            setMatched = false
        }
        
        for index in gridFrameView.subviews.indices {
            let cardFrame = gridFrameView.subviews[index]
            if tappedCardIndices.contains(index) {
                cardFrame.layer.borderWidth = 6.0
                cardFrame.layer.borderColor = UIColor.blue.cgColor
            } else {
                cardFrame.layer.borderWidth = 0.0
                cardFrame.layer.borderColor = nil
            }
        }
        if tappedCardIndices.count == 3 {
            let tappedCards = tappedCardIndices.map { game.playedCards[$0] }
            if game.evaluateSet(of: tappedCards) {
                setMatched = true
            } else {
                tappedCardIndices.removeAll()
            }
        }
    }
    
    private func setMatchUI() {
        setMatched = true
        let bounds = self.view.bounds
        let button = UIButton(frame: CGRect(x: bounds.midX, y: bounds.midY, width: CGFloat(integerLiteral: 200), height: CGFloat(integerLiteral: 200)))
        
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeColor : UIColor.black,
            .strokeWidth : 20.0
        ]
        let attributedString = NSAttributedString(string: "Set is matched!", attributes: attributes)
        
        button.setAttributedTitle(attributedString, for: UIControl.State.normal)
        for subview in gridFrameView.subviews {
            subview.removeFromSuperview()
        }
        self.view.addSubview(button)
        self.view.bringSubviewToFront(button)
    }
    
    private func updateUI() {
        gridFrameView.numberOfPlayedCards = game.playedCards.count
        for subview in gridFrameView.subviews {
            subview.removeFromSuperview()
        }
        gridFrameView.setCardViews.removeAll()
        for card in game.playedCards {
            let setCardView = SetCardView()
            setCardView.card = card
            gridFrameView.setCardViews.append(setCardView)
        }
        for subview in gridFrameView.subviews {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
            subview.addGestureRecognizer(tap)
        }
    }
}
    //    @IBOutlet weak var setCardView: SetCardView! {
//        didSet {
//            let tap = UITapGestureRecognizer(target: setCardView, action: #selector(SetCardView.tapCard(byHandlingGestureRecognizedBy: )))
//            setCardView.addGestureRecognizer(tap)
//        }
//    }
    
//
//    private lazy var game = SetGame()
//    private var chosenButtons = [UIButton]()
//    private var setMatched = false
//    private let cardColor = [#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)]
//    private let cardShape = ["●", "▲", "■"]
//
//    @IBOutlet var cardButtons: [UIButton]!
//
//    @IBOutlet weak var dealButton: UIButton! {
//        didSet {
//            dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
//        }
//    }
//    @IBOutlet weak var matchResult: UILabel!
//
//    @IBAction func chooseCard(_ sender: UIButton) {
//        if setMatched {
//            updateViewFromModel()
//            setMatched = false
//        }
//        let cardNumber = cardButtons.index(of: sender)
////        user can only select cards that are on display
//        if (game.playedCards[cardNumber!] != nil) {
////            user deselect card when the same card is selected again
//            if chosenButtons.contains(sender) {
//                chosenButtons = chosenButtons.filter { $0 != sender }
//            } else {
//                chosenButtons.append(sender)
////                game.evaluateSet is called when user selects 3 cards
//                if chosenButtons.count == 3 {
//                    var chosenCards = [Card]()
//                    for button in chosenButtons {
//                        let cardNumber = cardButtons.index(of: button)
//                        chosenCards.append(game.playedCards[cardNumber!]!)
//                    }
//                    setMatched = game.evaluateSet(of: chosenCards)
//                    if setMatched {
//                        matchResult.text = "Matched!"
//                        dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
//                    } else {
//                        matchResult.text = "Mismatched!"
//                    }
//                }
//            }
//        }
//       updateChosenCards(with: chosenButtons.count)
//    }
//
//    private func updateChosenCards(with numberOfChosenButtons: Int) {
//        for card in cardButtons {
//            if chosenButtons.contains(card) {
//                card.layer.borderWidth = 3.0
//                card.layer.borderColor = UIColor.blue.cgColor
//            } else {
//                card.layer.borderWidth = 0.0
//                card.layer.borderColor = nil
//            }
//        }
//        if numberOfChosenButtons == 3 {
//            chosenButtons = [UIButton]()
//        } else {
//            matchResult.text = ""
//        }
//    }
//
//    @IBAction func startGame(_ sender: UIButton) {
//        game = SetGame()
//        updateViewFromModel()
//    }
//
//    @IBAction func dealCard(_ sender: UIButton) {
//        let numberOfFaceUpCards = game.playedCards.filter { $0 != nil }.count
//        if numberOfFaceUpCards <= 21 {
//            if game.cards.count != 0 {
//                game.dealCards(with: 3)
//                updateViewFromModel()
//                dealButton.setTitle("Deal (\(game.cards.count))", for: UIControl.State.normal)
//            } else {
//                dealButton.setTitle("Cards empty", for: UIControl.State.normal)
//            }
//            if numberOfFaceUpCards == 21 {
//                dealButton.setTitle("Cards full (\(game.cards.count))", for: UIControl.State.normal)
//            }
//        }
//    }
//
//    private func updateViewFromModel() {
//        var displayNumber: String
//        var displayShape: String
//        var displayFill: Float
//        var displayColor: UIColor
//
//        for cardIndex in game.playedCards.indices
//        {
//            if game.playedCards[cardIndex] == nil {
//                cardButtons[cardIndex].backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
//            } else {
//                cardButtons[cardIndex].backgroundColor = #colorLiteral(red: 0.8804528871, green: 0.8804528871, blue: 0.8804528871, alpha: 0.0981645976)
//            }
//        }
//
//        for index in cardButtons.indices {
//            let button = cardButtons[index]
//            let card = game.playedCards[index]
//            button.setTitle("", for: UIControl.State.normal)
//
//            switch card?.shape {
//            case .choiceOne?: displayShape = cardShape[0]
//            case .choiceTwo?: displayShape = cardShape[1]
//            case .choiceThree?: displayShape = cardShape[2]
//            default: displayShape = ""
//            }
//
//            switch card?.number {
//            case .choiceOne?: displayNumber = displayShape
//            case .choiceTwo?: displayNumber = "\(displayShape) \(displayShape)"
//            case .choiceThree?: displayNumber = "\(displayShape) \(displayShape) \(displayShape)"
//            default: displayNumber = ""
//            }
//
//            switch card?.color {
//            case .choiceOne?: displayColor = cardColor[0]
//            case .choiceTwo?: displayColor = cardColor[1]
//            case .choiceThree?: displayColor = cardColor[2]
//            case .none: displayColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
//            }
//
//            switch card?.shade {
//            case .choiceOne?:
//                displayFill = -1.0
//                displayColor = displayColor.withAlphaComponent(0.15)
//            case .choiceTwo?: displayFill = -1.0
//            case .choiceThree?: displayFill = 5.0
//            default: displayFill = 5.0
//            }
//
//            let attributes: [NSAttributedString.Key:Any] = [
//                .strokeColor : displayColor,
//                .strokeWidth : displayFill,
//                .foregroundColor: displayColor,
//            ]
//            let attributedString = NSAttributedString(string: displayNumber, attributes: attributes)
//            button.setAttributedTitle(attributedString, for: UIControl.State.normal)
//        }
//    }
//}


