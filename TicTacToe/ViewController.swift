//
//  ViewController.swift
//  TicTacToe
//
//  Created by Jonathan L. on 7/30/17.
//  Copyright © 2017 Jonathan L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    @IBOutlet weak var player1CrossOrCircleLabel: UILabel!
    @IBOutlet weak var btnXForPlayer1: UIButton!
    @IBOutlet weak var btnOForPlayer1: UIButton!
    @IBOutlet weak var gameStatusDisplay: UILabel!
    @IBOutlet weak var resetGameBtn: UIButton!
    @IBOutlet weak var lineWhenTicTacToeWinsView: LineWhenTicTacToeWins!
    
    private var player1 = ""
    private var player2 = ""
    private var player1Turn = true
    private var game = TicTacToeLogic()
    private var numberOfMoves = 0
    private var buttonsOnTheBoard: [UIButton]?
    
    private var gameStarted = false
    
    @IBAction func pressedResetGame(_ sender: UIButton) {
        gameStarted = false
        player1 = ""
        player2 = ""
        player1Turn = true
        game = TicTacToeLogic()
        numberOfMoves = 0
        btnXForPlayer1.isHidden = false
        btnOForPlayer1.isHidden = false
        player1CrossOrCircleLabel.text = "Is player 1 an X or O?"
        gameStatusDisplay.text = "Select player type to start game"
        resetGameBtn.isHidden = true
        
        for button in buttonsOnTheBoard! {
            button.setTitle("", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        lineWhenTicTacToeWinsView.positionThatWon = 0
        lineWhenTicTacToeWinsView.directionOfWin = .noDirection
    }
    @IBAction func pressedPlayer1CrossOrCircleSelection(_ sender: UIButton) {
        if sender.currentTitle == "X" {
            player1 = "X"
            player2 = "O"
            player1CrossOrCircleLabel.text = "Player 1 is X"
            
        }
        else {
            player1 = "O"
            player2 = "X"
            player1CrossOrCircleLabel.text = "Player 1 is O"
        }
        
        gameStarted = true
        resetGameBtn.isHidden = false
        gameStatusDisplay.text = "Player 1 make your move."
        btnXForPlayer1.isHidden = true
        btnOForPlayer1.isHidden = true
        buttonsOnTheBoard = [button1, button2, button3, button4, button5, button6, button7, button8, button9]
        
    }
    
    @IBAction func pressedMoveBtn(_ sender: UIButton) {
        if gameStarted {
            if player1Turn {
                // Disallow illegal moves like changing a space already occupied by a player
                if (sender.currentTitle == player1) || (sender.currentTitle == player2) {
                    player1Turn = true
                    gameStatusDisplay.text = "Invalid move.  Try again player 1."
                }
                else {
                    game.setPosition(playerType: player1, position: sender.tag)
                    sender.setTitle(player1, for: .normal)
                    
                    player1Turn = false
                    gameStatusDisplay.text = "Player 2 make your move."
                }
            }
            else {
                // Disallow illegal moves like changing a space already occupied by a player
                if (sender.currentTitle == player1) || (sender.currentTitle == player2) {
                    player1Turn = false
                    gameStatusDisplay.text = "Invalid move.  Try again player 2."
                }
                else {
                    game.setPosition(playerType: player2, position: sender.tag)
                    sender.setTitle(player2, for: .normal)
                    
                    player1Turn = true
                    gameStatusDisplay.text = "Player 1 make your move."
                }

            }
            numberOfMoves += 1
            
            // Check to see if there is a winner if more than 4 moves
            if numberOfMoves > 4 {
                let didSomeoneWin = game.didSomeoneWin()
                switch didSomeoneWin.whoWon {
                case .crossWins:
                    if player1 == "X" {
                        gameStatusDisplay.text = "Player 1 wins!!!"
                    }
                    else {
                        gameStatusDisplay.text = "Player 2 wins!!!"
                    }
                    
                    // Turn winning symbol red and draw a line through the winning selection
                    buttonsOnTheBoard![didSomeoneWin.winningPosition1 - 1].setTitleColor(UIColor.red, for: .normal)
                    buttonsOnTheBoard![didSomeoneWin.winningPosition2 - 1].setTitleColor(UIColor.red, for: .normal)
                    buttonsOnTheBoard![didSomeoneWin.winningPosition3 - 1].setTitleColor(UIColor.red, for: .normal)
                    
                    lineWhenTicTacToeWinsView.positionThatWon = didSomeoneWin.winningPosition1
                    lineWhenTicTacToeWinsView.directionOfWin = didSomeoneWin.directionOfWin
                    gameStarted = false
                case .circleWins:
                    if player1 == "O" {
                        gameStatusDisplay.text = "Player 1 wins!!!"
                    }
                    else {
                        gameStatusDisplay.text = "Player 2 wins!!!"
                    }
                    
                    // Turn winning symbol red and draw a line through the winning selection
                    buttonsOnTheBoard![didSomeoneWin.winningPosition1 - 1].setTitleColor(UIColor.blue, for: .normal)
                    buttonsOnTheBoard![didSomeoneWin.winningPosition2 - 1].setTitleColor(UIColor.blue, for: .normal)
                    buttonsOnTheBoard![didSomeoneWin.winningPosition3 - 1].setTitleColor(UIColor.blue, for: .normal)
                    
                    lineWhenTicTacToeWinsView.positionThatWon = didSomeoneWin.winningPosition1
                    lineWhenTicTacToeWinsView.directionOfWin = didSomeoneWin.directionOfWin
                    gameStarted = false
                case .draw:
                    gameStatusDisplay.text = "No one wins . . . draw."
                    for button in buttonsOnTheBoard! {
                        button.setTitleColor(UIColor.yellow, for: .normal)
                    }
                    gameStarted = false
                case .gameStillGoing:
                    break
                }
            }
        }
    }
    

}

