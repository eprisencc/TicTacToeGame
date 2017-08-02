//
//  LineWhenTicTacToeWins.swift
//  TicTacToe
//
//  Created by Jonathan L. on 7/31/17.
//  Copyright © 2017 Jonathan L. All rights reserved.
//

import UIKit

enum DirectionOfWin {
    case across
    case down
    case diagonal
    case noDirection
}

class LineWhenTicTacToeWins: UIView {
    var positionThatWon: Int = 0
    var directionOfWin: DirectionOfWin = .noDirection {
        didSet {
            setNeedsDisplay()
        }
    }
    
    func whereToStartDrawing(winningPosition: Int, direction: DirectionOfWin) -> (start: CGPoint, end: CGPoint) {
        let lineGap: CGFloat = 20
        var startingPoint = CGPoint.zero
        var endingPoint = CGPoint.zero
        switch winningPosition {
        case 1:
            switch direction {
            case .across:
                startingPoint = CGPoint(x: lineGap, y: bounds.size.height / 3 / 2)
                endingPoint = CGPoint(x: bounds.size.width - lineGap, y: bounds.size.height / 3 / 2)
            case .down:
                startingPoint = CGPoint(x: bounds.size.width / 3 / 2, y: lineGap)
                endingPoint = CGPoint(x: bounds.size.width / 3 / 2, y: bounds.size.height - lineGap)
            case .diagonal:
                startingPoint = CGPoint(x: lineGap, y: lineGap)
                endingPoint = CGPoint(x: bounds.size.width - lineGap, y: bounds.size.height - lineGap)
            default:
                break
            }
        case 2:
            // Direction is only down for this case
            startingPoint = CGPoint(x: bounds.size.width / 2, y: lineGap)
            endingPoint = CGPoint(x: bounds.size.width / 2, y: bounds.size.height - lineGap)
        case 3:
            // Direction is only diagonally and down for this case
            switch direction {
            case .down:
                startingPoint = CGPoint(x: bounds.size.width - (bounds.size.width / 3 / 2), y: lineGap)
                endingPoint = CGPoint(x: bounds.size.width - (bounds.size.width / 3 / 2), y: bounds.size.height - lineGap)
            case .diagonal:
                startingPoint = CGPoint(x: bounds.size.width - lineGap, y: lineGap)
                endingPoint = CGPoint(x: lineGap, y: bounds.size.height - lineGap)
            default:
                break
            }
        case 4:
            // Direction is across only for this case
            startingPoint = CGPoint(x: lineGap, y: bounds.size.height / 2)
            endingPoint = CGPoint(x: bounds.size.width - lineGap, y: bounds.size.height / 2)
        case 7:
            // Direction is across only for this case
            startingPoint = CGPoint(x: lineGap, y: bounds.size.height - (bounds.size.height / 3 / 2))
            endingPoint = CGPoint(x: bounds.size.width - lineGap, y: bounds.size.height - (bounds.size.height / 3 / 2))
        default:
            break
        }
        return (startingPoint, endingPoint)
    }
    
    func pathforDrawWinner() -> UIBezierPath {
        let pointsToDraw: (start: CGPoint, end: CGPoint) = whereToStartDrawing(winningPosition: positionThatWon, direction: directionOfWin)
        let path = UIBezierPath()
        path.move(to: pointsToDraw.start)
        path.addLine(to: pointsToDraw.end)
        path.lineWidth = 5.0
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.red.set()
        pathforDrawWinner().stroke()
    }

}
