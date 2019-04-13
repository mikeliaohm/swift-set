//
//  SetCardView.swift
//  set
//
//  Created by Hsin-Min Liao on 2019/3/26.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    
    var card = Card(color: .choiceOne, number: .choiceOne, shade: .choiceOne, shape: .choiceOne) { didSet { setNeedsDisplay(); setNeedsLayout() } }
//
//    var color: Attributes = .choiceOne { didSet { setNeedsDisplay(); setNeedsLayout() } }
//    
//    var number: Attributes = .choiceOne { didSet { setNeedsDisplay(); setNeedsLayout() } }
//
//    var shade: Attributes = .choiceOne { didSet { setNeedsDisplay(); setNeedsLayout() } }
//
//    var shape: Attributes = .choiceOne { didSet { setNeedsDisplay(); setNeedsLayout() } }
//
//    enum Attributes: String, CustomStringConvertible {
//        var description: String { return rawValue }
//
//        case choiceOne = "one"
//        case choiceTwo = "two"
//        case choiceThree = "three"
//    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        
        let gridFrame = UIBezierPath(rect: bounds)
        UIColor.white.setFill()
        gridFrame.fill()
        
        var cardPatternPaths = [UIBezierPath]()
        var cardPatternPath = UIBezierPath()
        var cardPatternColor: UIColor
        
        UIColor.black.setStroke()
        gridFrame.lineWidth = 3.0
        gridFrame.stroke()
        
        switch card.shape {
        case .choiceOne: cardPatternPath = drawDiamondPath(in: gridFrame)
        case .choiceTwo: cardPatternPath = drawOvalPath(in: gridFrame)
        case .choiceThree: cardPatternPath = drawSquigglePath(in: gridFrame)
        }
        
        switch card.color {
        case .choiceOne: cardPatternColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        case .choiceTwo: cardPatternColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        case .choiceThree: cardPatternColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
        let pathTwo = cardPatternPath.copy() as! UIBezierPath
        let pathThree = cardPatternPath.copy() as! UIBezierPath
        
        switch card.number {
        case .choiceOne: cardPatternPaths.append(cardPatternPath)
        case .choiceTwo:
            cardPatternPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -gridFrame.spaceToCorner * 2.5))
            cardPatternPaths.append(pathTwo)
            cardPatternPaths.append(cardPatternPath)
            pathTwo.apply(CGAffineTransform.identity.translatedBy(x: 0, y: gridFrame.spaceToCorner * 2.5))
            cardPatternPaths.append(pathTwo)
        case .choiceThree:
            cardPatternPaths.append(cardPatternPath)
            pathTwo.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -(gridFrame.shapeHeight + gridFrame.spaceToCorner)))
            cardPatternPaths.append(pathTwo)
            pathThree.apply(CGAffineTransform.identity.translatedBy(x: 0, y: (gridFrame.shapeHeight + gridFrame.spaceToCorner)))
            cardPatternPaths.append(pathThree)
        }
        
        cardPatternColor.setStroke()
        cardPatternColor.setFill()
        
        for path in cardPatternPaths {
            switch card.shade {
            case .choiceOne: path.stroke()
            case .choiceTwo: path.fill()
            case .choiceThree:
                path.stroke()
                let context = UIGraphicsGetCurrentContext()
                context?.saveGState()
                path.addClip()
                
                let stripes = UIBezierPath()
                for i in stride(from: gridFrame.bounds.minX, to: gridFrame.bounds.maxX, by: 10) {
                    stripes.move(to: CGPoint(x: i, y: gridFrame.bounds.minY))
                    stripes.addLine(to: CGPoint(x: i, y: gridFrame.bounds.maxY))
                }
                stripes.stroke()
                context?.restoreGState()
            }
        }
    }
    
    func drawDiamondPath(in gridFrame: UIBezierPath) -> UIBezierPath {
        
        let diamondPath = UIBezierPath()
        
        diamondPath.move(to: CGPoint(x: gridFrame.startingPointX + gridFrame.cellWidth / 2 - gridFrame.spaceToCorner, y: gridFrame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: gridFrame.startingPointX, y: gridFrame.startingPointY - gridFrame.shapeHeight / 2))
        diamondPath.addLine(to: CGPoint(x: gridFrame.startingPointX - gridFrame.cellWidth / 2 + gridFrame.spaceToCorner, y: gridFrame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: gridFrame.startingPointX, y: gridFrame.startingPointY + gridFrame.shapeHeight / 2))
        diamondPath.close()
        return diamondPath
    }
    
    func drawOvalPath(in gridFrame: UIBezierPath) -> UIBezierPath {
        let rectShape = CGRect(x: gridFrame.startingPointX - gridFrame.cellWidth / 2 + gridFrame.spaceToCorner, y: gridFrame.startingPointY - gridFrame.shapeHeight / 3, width: gridFrame.cellWidth - gridFrame.spaceToCorner * 2, height: gridFrame.shapeHeight / 3 * 2)
        let ovalPath = UIBezierPath(roundedRect: rectShape, cornerRadius: gridFrame.shapeHeight / 5)
        return ovalPath
    }
    
    func drawSquigglePath(in gridFrame: UIBezierPath) -> UIBezierPath {
        let squigglePath = UIBezierPath(arcCenter: CGPoint(x: gridFrame.startingPointX, y: gridFrame.startingPointY), radius: gridFrame.shapeHeight / 3, startAngle: 0, endAngle: 90, clockwise: true)
        
        return squigglePath
    }
}

extension UIBezierPath {
    private struct SizeRatio {
        static let spaceRatio: CGFloat = 10
    }
    
    var cellWidth: CGFloat {
        return bounds.width
    }
    var cellHeight: CGFloat {
        return bounds.height
    }
    var shapeHeight: CGFloat {
        return (cellHeight - spaceToCorner * 4) / 3
    }
    var shapeWidth: CGFloat {
        return cellWidth - spaceToCorner * 2
    }
    var startingPointY: CGFloat {
        return bounds.midY
    }
    var startingPointX: CGFloat {
        return bounds.midX
    }
    var spaceToCorner: CGFloat {
        return cellWidth / SizeRatio.spaceRatio
    }
}

//    @objc func tapCard(sender: UITapGestureRecognizer) {
//        print("buttons: \(cellButtons.count)")
//        if setMatched {
//            cellButtons = [UIButton]()
////            updateDisplayedPlayedCards()
//            setMatched = false
//        }

//        if sender.state == .ended {
//            if let tappedCardIndex = cellButtons.index(of: sender.view as! UIButton) {
//                print("chosen card: \(tappedCardIndex)")
//                if chosenCardIndics.contains(tappedCardIndex) {
//                    chosenCardIndics = chosenCardIndics.filter { $0 != tappedCardIndex }
//                } else {
//                    chosenCardIndics.append(tappedCardIndex)
//                }
//                if chosenCardIndics.count == 3 {
//                    var chosenCards = [Card]()
//                    for cardIndex in chosenCardIndics { chosenCards.append(game.playedCards[cardIndex]) }
//                    setMatched = game.evaluateSet(of: chosenCards)
//                    if setMatched {
//                        print("game matched!")
//                    } else {
//                        print("game mismatched!")
//                    }
//                }
//            }
//        }
//        updateDisplayedChosenCard()
//    }
//
//    private func updateDisplayedChosenCard() {
//        for index in 0..<game.playedCards.count {
//            if chosenCardIndics.contains(index) {
//                cellButtons[index].layer.borderWidth = 6.0
//                cellButtons[index].layer.borderColor = UIColor.blue.cgColor
//            } else {
//                cellButtons[index].layer.borderWidth = 0.0
//                cellButtons[index].layer.borderColor = nil
//            }
//        }
//        if chosenCardIndics.count == 3 {
//            chosenCardIndics = [Int]()
//        } else {
//            print("select \(3 - chosenCardIndics.count) card(s) to evaluate a set.")
//        }
//    }
//
//    func updateDisplayedPlayedCards() {
//        for view in self.subviews {
//            view.removeFromSuperview()
//        }
////        Determine the grid row and column size
//        let gridlayout = layoutGrid(with: game.playedCards.count)
//        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: gridlayout[0], columnCount: gridlayout[1]), frame: gridFrame)
//
//        for (index, card) in game.playedCards.enumerated() {
//            let cellFrame = UIBezierPath(roundedRect: grid[index]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
//            UIColor.black.setStroke()
//            cellFrame.lineWidth = 3.0
//            cellFrame.stroke()
//
//            let cellRect = CGRect(x: cellFrame.bounds.minX, y: cellFrame.bounds.minY, width: cellFrame.cellWidth, height: cellFrame.cellHeight)
//            let cellButton = UIButton(frame: cellRect)
//            cellButton.layer.borderWidth = 3.0
//            cellButton.layer.borderColor = UIColor.yellow.cgColor
//            addSubview(cellButton)
//            drawCardPattern(cellFrame: cellFrame, card: card)
//            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCard))
//            cellButton.addGestureRecognizer(tap)
//            cellButtons.append(cellButton)
//        }
//    }
//
