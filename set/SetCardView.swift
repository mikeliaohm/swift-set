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

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    */
    var deck = SetCardDeck()
    lazy var gridFrame = bounds
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let cardsDrawn = deck.dealCards(with: 12)
//        print("\(cardsDrawn)")
//    }
    
    private func drawCardPattern(cellFrame frame: UIBezierPath, card: Card) {
        
        var cardPatternPaths = [UIBezierPath]()
        var cardPatternPath = UIBezierPath()
        var cardPatternColor: UIColor
        
        switch card.shape {
        case .choiceOne: cardPatternPath = drawDiamondPath(cellFrame: frame)
        case .choiceTwo: cardPatternPath = drawOvalPath(cellFrame: frame)
        case .choiceThree: cardPatternPath = drawSquigglePath(cellFrame: frame)
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
            cardPatternPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -frame.spaceToCorner * 2.5))
            cardPatternPaths.append(pathTwo)
            cardPatternPaths.append(cardPatternPath)
            pathTwo.apply(CGAffineTransform.identity.translatedBy(x: 0, y: frame.spaceToCorner * 2.5))
            cardPatternPaths.append(pathTwo)
        case .choiceThree:
            cardPatternPaths.append(cardPatternPath)
            pathTwo.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -(frame.shapeHeight + frame.spaceToCorner)))
            cardPatternPaths.append(pathTwo)
            pathThree.apply(CGAffineTransform.identity.translatedBy(x: 0, y: (frame.shapeHeight + frame.spaceToCorner)))
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
                for i in stride(from: frame.bounds.minX, to: frame.bounds.maxX, by: 10) {
                    stripes.move(to: CGPoint(x: i, y: frame.bounds.minY))
                    stripes.addLine(to: CGPoint(x: i, y: frame.bounds.maxY))
                }
                stripes.stroke()
                context?.restoreGState()
            }
        }
    }
    
    private func drawDiamondPath(cellFrame frame: UIBezierPath) -> UIBezierPath {

        let diamondPath = UIBezierPath()
        
        diamondPath.move(to: CGPoint(x: frame.startingPointX + frame.cellWidth / 2 - frame.spaceToCorner, y: frame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX, y: frame.startingPointY - frame.shapeHeight / 2))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX - frame.cellWidth / 2 + frame.spaceToCorner, y: frame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX, y: frame.startingPointY + frame.shapeHeight / 2))
        diamondPath.close()
        return diamondPath
    }
    
    private func drawOvalPath(cellFrame frame: UIBezierPath) -> UIBezierPath {
        let rectShape = CGRect(x: frame.startingPointX - frame.cellWidth / 2 + frame.spaceToCorner, y: frame.startingPointY - frame.shapeHeight / 3, width: frame.cellWidth - frame.spaceToCorner * 2, height: frame.shapeHeight / 3 * 2)
        let ovalPath = UIBezierPath(roundedRect: rectShape, cornerRadius: frame.shapeHeight / 5)
        return ovalPath
    }
    
    private func drawSquigglePath(cellFrame frame: UIBezierPath) -> UIBezierPath {
        let squigglePath = UIBezierPath(arcCenter: CGPoint(x: frame.startingPointX, y: frame.startingPointY), radius: frame.shapeHeight / 3, startAngle: 0, endAngle: 90, clockwise: true)

        return squigglePath
    }
    
    override func draw(_ rect: CGRect) {
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 4, columnCount: 3), frame: gridFrame)
        
        
        let cards = deck.dealCards(with: 12)
        for (index, card) in cards.enumerated() {
            let cellFrame = UIBezierPath(roundedRect: grid[index]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
            UIColor.black.setStroke()
            cellFrame.lineWidth = 3.0
            cellFrame.stroke()
            drawCardPattern(cellFrame: cellFrame, card: card)
        }
        print("\(cards)")

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
