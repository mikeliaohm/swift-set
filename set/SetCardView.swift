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
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 5, columnCount: 5), frame: gridFrame)
        
        let roundedRectOne = UIBezierPath(roundedRect: grid[1, 1]!, cornerRadius: 0.0)
        let roundedRectTwo = UIBezierPath(roundedRect: grid[1, 2]!, cornerRadius: 0.0)
        let roundedRectThree = UIBezierPath(roundedRect: grid[0, 0]!, cornerRadius: 0.0)
        let roundedRectFour = UIBezierPath(roundedRect: grid[4, 4]!, cornerRadius: 0.0)
        let roundedRectFive = UIBezierPath(roundedRect: grid[3, 0]!, cornerRadius: 0.0)
        UIColor.green.setFill()
        roundedRectOne.fill()
        roundedRectTwo.fill()
        roundedRectThree.fill()
        roundedRectFour.fill()
        roundedRectFive.fill()
    }
}
