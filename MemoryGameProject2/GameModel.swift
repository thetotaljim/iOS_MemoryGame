//
//  GameModel.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/28/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

    //  The game model class holds all the data for the matching game.  //

class GameModel {
    
    /********************************************************************/
    /*  These are arrays holding the names of the card png files to     */
    /*  use for the matching game.                                      */
    /********************************************************************/
    
    var cardNames6 : [String] = ["ace_of_spades.png", "king_of_diamonds2.png","king_of_hearts2.png","king_of_spades2.png", "king_of_clubs2.png", "queen_of_hearts2.png", "queen_of_diamonds2.png", "queen_of_clubs2.png", "queen_of_spades2.png", "jack_of_hearts2.png", "jack_of_diamonds2.png", "jack_of_clubs2.png", "jack_of_spades2.png", "10_of_hearts.png", "10_of_diamonds.png", "10_of_clubs.png", "10_of_spades.png",  "red_joker.png", "ace_of_spades.png", "king_of_diamonds2.png", "king_of_hearts2.png", "king_of_spades2.png", "king_of_clubs2.png", "queen_of_hearts2.png", "queen_of_diamonds2.png", "queen_of_clubs2.png", "queen_of_spades2.png", "jack_of_hearts2.png", "jack_of_diamonds2.png", "jack_of_clubs2.png", "jack_of_spades2.png", "10_of_hearts.png", "10_of_diamonds.png", "10_of_clubs.png", "10_of_spades.png", "red_joker.png"]
    
    var cardNames4 : [String] = ["king_of_hearts2.png", "king_of_clubs2.png", "queen_of_hearts2.png",  "queen_of_clubs2.png",  "jack_of_hearts2.png", "jack_of_clubs2.png",  "10_of_hearts.png",  "10_of_clubs.png", "king_of_hearts2.png", "king_of_clubs2.png", "queen_of_hearts2.png",  "queen_of_clubs2.png",  "jack_of_hearts2.png", "jack_of_clubs2.png",  "10_of_hearts.png",  "10_of_clubs.png"]
    
    var cardNames2 : [String] = ["ace_of_spades.png", "red_joker.png","ace_of_spades.png", "red_joker.png"]
    
    /************************************************************/
    /*  These are variables for the user's card deck            */
    /************************************************************/
    var userGameType : GameType = GameType.FourByFour
    var numPairsForWin : Int = 0
    var userCardDeck : [MemoryCard?]
    
    /************************************************************/
    /*  These are variables used for flipping cards and         */
    /*  tracking matching hands                                 */
    /************************************************************/
    var matchedCardIndexPathes = [IndexPath]()
    var flipCheckIndexes = [Int]()
    var numFlippedCards = 0
    var numMatchedPairs = 0
    var indexPaths = [IndexPath]()
    
    /************************************************************/
    /*  Initialize the GameModel using the user's selected      */
    /*  game type and then generate an array of MemoryCard      */
    /*  objects.                                                */
    /************************************************************/
    init(gameType: GameType){
        self.userGameType = gameType
        self.userCardDeck = []
        addCardsToUserCardDeck()
        self.userCardDeck.shuffle()
        setNumPairsForWin()
    }
    
    /************************************************************/
    /*  Here an array of MemoryCard objects is generated for    */
    /*  the user based on their game type.                      */
    /************************************************************/
    func addCardsToUserCardDeck () {
        if (self.userGameType == GameType.TwoByTwo){
            for index in 0...3 {
                let tempCard : MemoryCard = MemoryCard()
                tempCard.cardFrontImageName = cardNames2[index]
                userCardDeck.insert(tempCard, at: index)
            }
        }
        else if (self.userGameType == GameType.SixBySix){
            for index in 0...35 {
                let tempCard : MemoryCard = MemoryCard()
                tempCard.cardFrontImageName = cardNames6[index]
                userCardDeck.append(tempCard)
            }
        }
        else {
            for index in 0...15 {
                let tempCard : MemoryCard = MemoryCard()
                tempCard.cardFrontImageName = cardNames4[index]
                userCardDeck.append(tempCard)
            }
        }
    }
    /************************************************************/
    /*  Set the number of pairs it will take to win the game    */
    /************************************************************/
    func setNumPairsForWin() {
        switch self.userGameType {
        case .TwoByTwo :
            numPairsForWin = 2
        case .SixBySix :
            numPairsForWin = 18
        default :
            numPairsForWin = 8
        }
    }
}
/****************************************************************/
/*  This extension of the Array class will allow the use of     */
/*  shuffle() function to randomize the order of an array's     */
/*  elements.                                                   */
/****************************************************************/
extension Array
{/** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
