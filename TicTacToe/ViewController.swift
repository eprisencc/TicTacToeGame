//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jonathan L. on 7/30/17.
//  Copyright © 2017 Jonathan L. All rights reserved.
//

import UIKit

@IBDesignable
class ViewController: UIViewController {
    
    @IBOutlet weak var moveBtn: UIButton!
    
    @IBInspectable
    private var btnScaleFactor: Double = 0.9 // Should be a number from 0 to 1
    
    @IBAction func pressedMoveBtn(_ sender: UIButton) {
        let sizeOfBtn = CGSize(width: sender.frame.width * CGFloat(btnScaleFactor), height: sender.frame.height * CGFloat(btnScaleFactor))
        
        sender.frame.size = sizeOfBtn
        sender.setImage(#imageLiteral(resourceName: "Cross"), for: UIControlState.normal)
        print(sender.tag)
        
        var testTicTacToe = TicTacToeLogic()
        
        /*testTicTacToe.setPosition(moveByPlayer: .cross, position: 2)
        testTicTacToe.setPosition(moveByPlayer: .circle, position: 8)
        testTicTacToe.setPosition(moveByPlayer: .cross, position: 9)*/
        
        print(testTicTacToe.didSomeoneWin())
    }
    

}

