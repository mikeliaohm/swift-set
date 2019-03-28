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
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    lazy var gridFrame = bounds
    
    private func drawDiamondShape(cellFrame frame: UIBezierPath) -> UIBezierPath {

        let diamondPath = UIBezierPath()
        
        diamondPath.move(to: CGPoint(x: frame.startingPointX + frame.cellWidth / 2 - frame.spaceToCorner, y: frame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX, y: frame.startingPointY - frame.shapeHeight / 2))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX - frame.cellWidth / 2 + frame.spaceToCorner, y: frame.startingPointY))
        diamondPath.addLine(to: CGPoint(x: frame.startingPointX, y: frame.startingPointY + frame.shapeHeight / 2))
        diamondPath.close()
        return diamondPath
    }
    
    private func drawOvalShape(cellFrame frame: UIBezierPath) -> UIBezierPath {
        let rectShape = CGRect(x: frame.startingPointX - frame.cellWidth / 2 + frame.spaceToCorner, y: frame.startingPointY - frame.shapeHeight / 3, width: frame.cellWidth - frame.spaceToCorner * 2, height: frame.shapeHeight / 3 * 2)
        let ovalPath = UIBezierPath(roundedRect: rectShape, cornerRadius: frame.shapeHeight / 5)
        return ovalPath
    }
    
    private func drawSquiggleShape(cellFrame frame: UIBezierPath) -> UIBezierPath {
        let squigglePath = UIBezierPath(arcCenter: CGPoint(x: frame.startingPointX, y: frame.startingPointY), radius: frame.shapeHeight / 3, startAngle: 0, endAngle: 90, clockwise: true)

        return squigglePath
    }
    
    override func draw(_ rect: CGRect) {
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 3, columnCount: 3), frame: gridFrame)

        let roundedRect = UIBezierPath(roundedRect: grid[0, 1]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRect.fill()
        
        let diamondPath = drawDiamondShape(cellFrame: roundedRect)
        diamondPath.stroke()
        diamondPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: roundedRect.shapeHeight + roundedRect.spaceToCorner))
        diamondPath.stroke()
        
        diamondPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -(roundedRect.shapeHeight + roundedRect.spaceToCorner) * 2))
        diamondPath.stroke()
        
        
        
        let roundedRectTwo = UIBezierPath(roundedRect: grid[1, 0]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRectTwo.fill()
        
        let ovalPath = drawOvalShape(cellFrame: roundedRectTwo)
        ovalPath.stroke()

        let roundedRectThree = UIBezierPath(roundedRect: grid[2, 2]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRectThree.fill()
        
        let squigglePath = drawSquiggleShape(cellFrame: roundedRectThree)
        squigglePath.stroke()
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
