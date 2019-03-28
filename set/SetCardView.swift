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
    
    override func draw(_ rect: CGRect) {
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 2, columnCount: 2), frame: gridFrame)

        let roundedRect = UIBezierPath(roundedRect: grid[0, 1]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRect.fill()
        
        let diamondPath = drawDiamondShape(cellFrame: roundedRect)
        diamondPath.stroke()
        
//        diamondPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: shapeHeight + cellHeight / spaceRatio))
//        diamondPath.stroke()
//
//        diamondPath.apply(CGAffineTransform.identity.translatedBy(x: 0, y: -(shapeHeight + cellHeight / spaceRatio) * 2))
//        diamondPath.stroke()
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
        return (cellHeight - (cellHeight / SizeRatio.spaceRatio) * 4) / 3
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
