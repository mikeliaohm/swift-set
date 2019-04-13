//
//  GridFrameView.swift
//  set
//
//  Created by Mike Liao on 2019/4/13.
//  Copyright © 2019 Hsin-Min Liao. All rights reserved.
//

import UIKit

class GridFrameView: UIView {
        
    @IBInspectable
    var numberOfPlayedCards = 12 { didSet { layoutSubviews() } }
    
    var setCardViews = [SetCardView]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for view in self.subviews {
            view.removeFromSuperview()
        }
        //        Determine the grid row and column size
        let gridlayout = layoutGrid(with: numberOfPlayedCards)
        let grid = Grid(layout: Grid.Layout.dimensions(rowCount: gridlayout[0], columnCount: gridlayout[1]), frame: bounds)
        
        for index in 0..<numberOfPlayedCards {
            let cellFrame = UIBezierPath(roundedRect: grid[index]!.insetBy(dx: 5.0, dy: 5.0), cornerRadius: 0.0)
            
            let setCardView = SetCardView()
            setCardView.frame = cellFrame.bounds
            setCardViews.append(setCardView)
            addSubview(setCardView)
        }
    }
}
    
extension GridFrameView {
    func layoutGrid(with numberOfPlayedCards: Int) -> [Int] {
        switch numberOfPlayedCards {
        case 0: return [0, 0]
        case 3: return [3, 2]
        case 9: return [3, 3]
        case 12: return [4, 3]
        case 15: return [5, 3]
        case 18: return [6, 3]
        case 21: return [7, 3]
        case 24: return [6, 4]
        case 27: return [7, 4]
        case 30: return [6, 5]
        case 33: return [7, 5]
        case 36: return [6, 6]
        case 39: return [7, 6]
        case 42: return [7, 6]
        case 45: return [8, 6]
        case 48: return [8, 6]
        case 51: return [9, 6]
        case 54: return [9, 6]
        case 57: return [9, 7]
        case 60: return [9, 7]
        case 63: return [9, 7]
        case 66: return [9, 8]
        case 69: return [9, 8]
        case 72: return [9, 8]
        case 75: return [9, 9]
        case 78: return [9, 9]
        case 81: return [9, 9]
        default: return [0, 0]
        }
    }
}
