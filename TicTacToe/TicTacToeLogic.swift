//
//  TicTacToeLogic.swift
//  TicTacToe
//
//  Created by Jonathan L. on 7/30/17.
//  Copyright © 2017 Jonathan L. All rights reserved.
//

import Foundation

enum CrossOrCircle {
    case cross
    case circle
    case freeSpace
}

enum DidSomeoneWin {
    case crossWins
    case circleWins
    case gameStillGoing
    case draw
}

struct TicTacToeLogic {
    private var ticTacToeBoard = Array(repeating: Array(repeating: "", count: 3), count: 3)
    
    private func convertPositionToRowColumn(_ position: Int) -> (row: Int, column: Int) {
        var row, column: Int?
        
        if position < 4 {
            row = 0
            column = position - 1
        }
        else if position < 7 {
            row = 1
            column = position - 4
        }
        else {
            row = 2
            column = position - 7
        }
        
        return (row!, column!)
    }
    
    // Position must be an Int from 1 through 9 because there are 9 spaces on the board
    mutating func setPosition(playerType: String, position: Int) {
        let currentPosition = convertPositionToRowColumn(position)
        ticTacToeBoard[currentPosition.row][currentPosition.column] = playerType
        //print(ticTacToeBoard)
    }
    
    mutating func didSomeoneWin() -> (whoWon: DidSomeoneWin, winningPosition1: Int, winningPosition2: Int, winningPosition3: Int, directionOfWin: DirectionOfWin) {
        var whoWon: DidSomeoneWin?
        var whatDirectionWasWin: DirectionOfWin?
        var winnerPosition1 , winnerPosition2, winnerPosition3: Int?
        
        
        // Check all rows for winner
        for row in 0...2 {
            if (ticTacToeBoard[row][0] == ticTacToeBoard[row][1]) && (ticTacToeBoard[row][1] == ticTacToeBoard[row][2]) && (ticTacToeBoard[row][2] != "") {
                if ticTacToeBoard[row][0] == "X" {
                    whoWon = .crossWins
                }
                else {
                    whoWon = .circleWins
                }
                switch row {
                case 0:
                    winnerPosition1 = 1
                    winnerPosition2 = 2
                    winnerPosition3 = 3
                case 1:
                    winnerPosition1 = 4
                    winnerPosition2 = 5
                    winnerPosition3 = 6
                case 2:
                    winnerPosition1 = 7
                    winnerPosition2 = 8
                    winnerPosition3 = 9
                default:
                    winnerPosition1 = 0
                    winnerPosition2 = 0
                    winnerPosition3 = 0
                }
                whatDirectionWasWin = .across
                break
            }
        }
        
        // If no winner after checking rows then check Columns for winner
        if whoWon == nil {
            for column in 0...2 {
                if (ticTacToeBoard[0][column] == ticTacToeBoard[1][column]) && (ticTacToeBoard[1][column] == ticTacToeBoard[2][column]) && (ticTacToeBoard[2][column] != "") {
                    if ticTacToeBoard[2][column] == "X" {
                        whoWon = .crossWins
                    }
                    else {
                        whoWon = .circleWins
                    }
                    
                    switch column {
                    case 0:
                        winnerPosition1 = 1
                        winnerPosition2 = 4
                        winnerPosition3 = 7
                    case 1:
                        winnerPosition1 = 2
                        winnerPosition2 = 5
                        winnerPosition3 = 8
                    case 2:
                        winnerPosition1 = 3
                        winnerPosition2 = 6
                        winnerPosition3 = 9
                    default:
                        winnerPosition1 = 0
                        winnerPosition2 = 0
                        winnerPosition3 = 0
                    }
                    whatDirectionWasWin = .down
                    break
                }
            }
        }
        // If no winner after checking rows and columns then check the two diagonals
        if whoWon == nil {
            if (ticTacToeBoard[0][0] == ticTacToeBoard[1][1]) && (ticTacToeBoard[1][1] == ticTacToeBoard[2][2]) && (ticTacToeBoard[2][2] != "") {
                if ticTacToeBoard[2][2] == "X" {
                    whoWon = .crossWins
                }
                else {
                    whoWon = .circleWins
                }
                
                winnerPosition1 = 1
                winnerPosition2 = 5
                winnerPosition3 = 9
                whatDirectionWasWin = .diagonal
            }
            else if (ticTacToeBoard[0][2] == ticTacToeBoard[1][1]) && (ticTacToeBoard[1][1] == ticTacToeBoard[2][0]) && (ticTacToeBoard[2][0] != "") {
                if ticTacToeBoard[2][0] == "X" {
                    whoWon = .crossWins
                }
                else {
                    whoWon = .circleWins
                }
                
                winnerPosition1 = 3
                winnerPosition2 = 5
                winnerPosition3 = 7
                whatDirectionWasWin = .diagonal
            }
        }
        
        // If no winner after checking all conditions then check to see if the game is still going or if there is a draw
        if whoWon == nil {
            for i in 0...2 {
                for j in 0...2 {
                    if ticTacToeBoard[i][j] == "" {
                        whoWon = .gameStillGoing
                        whatDirectionWasWin = .noDirection
                        winnerPosition1 = 0
                        winnerPosition2 = 0
                        winnerPosition3 = 0
                        break
                    }
                }
            }
            
            // If all spaces on the board have been taken up then declare game a draw
            if whoWon != .gameStillGoing {
                whoWon = .draw
                whatDirectionWasWin = .noDirection
                winnerPosition1 = 0
                winnerPosition2 = 0
                winnerPosition3 = 0
            }
        }
        
        return (whoWon!, winnerPosition1!, winnerPosition2!, winnerPosition3!, whatDirectionWasWin!)
    }
}
