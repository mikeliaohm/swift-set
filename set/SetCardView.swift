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
    
    override func draw(_ rect: CGRect) {
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 2, columnCount: 2), frame: gridFrame)

        let roundedRectOne = UIBezierPath(roundedRect: grid[0, 1]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRectOne.fill()

        print("\(grid[2]?.height)")
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 100, y: 100), radius: 50.0, startAngle: 0, endAngle: 90, clockwise: true)
        path.lineWidth = 5.0
        UIColor.red.setFill()
        UIColor.black.setStroke()
        path.stroke()
        
//        let path: UIBezierPath = path.copy() as! UIBezierPath
        path.apply(CGAffineTransform.identity.translatedBy(x: 50, y: 50))
        path.stroke()
        path.apply(CGAffineTransform.identity.translatedBy(x: 50, y: 50))
        
        path.apply(CGAffineTransform.identity.translatedBy(x: 50, y: 50))
        path.stroke()
        
        let diamondPath = UIBezierPath()
        diamondPath.move(to: CGPoint.zero)
        diamondPath.addLine(to: CGPoint(x: 500, y: 500))
        diamondPath.stroke()
        
        
        
    }
}
