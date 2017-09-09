//
//  GameViewController.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/28/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    /************************************************************/
    /*  CollectionView and Label for the GameView               */
    /************************************************************/
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var topLabel: UILabel!
    /************************************************************/
    /*  Model, cell identifier, and FlowLayout objects          */
    /************************************************************/
    var layout : MemoryCollectionViewFlowLayout?
    var model : GameModel? = nil
    let reuseIdentifier = "Cell"
    
    /************************************************************/
    /*  In viewDidLoad(), prepare the game using the user       */
    /*  GameType and the FlowLayout object.                     */
    /************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = ""
        self.layout = MemoryCollectionViewFlowLayout()
        self.layout?.setNumColumns(gameType: (self.model?.userGameType)!)
        gameCollectionView.collectionViewLayout = self.layout!
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    /********************************************************/
    /*  Tell the collection view how many cells to make     */
    /********************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.model?.userCardDeck.count)!
    }
    /********************************************************/
    /*  Make a MemoryCollectionViewCell for each index path */
    /********************************************************/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        // get a reference to the storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MemoryCollectionViewCell
        //  Adjust the cell based on the userCardDeck array item that
        //  matches the indexPath.item
        switch self.model?.userGameType.rawValue {
            case GameType.TwoByTwo.rawValue?:
                cell.cardFrontImageName = (self.model?.userCardDeck[indexPath.item]?.cardFrontImageName)!
            case GameType.SixBySix.rawValue?:
                cell.cardFrontImageName = (self.model?.userCardDeck[indexPath.item]?.cardFrontImageName)!
            default:
                cell.cardFrontImageName = (self.model?.userCardDeck[indexPath.item]?.cardFrontImageName)!
        }
        cell.imageView?.image = UIImage(named: (self.model?.userCardDeck[indexPath.item]?.cardBackImageName)!)
        cell.hasBeenFlipped = true
        //  Return the cell.
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    /************************************************************************/
    /*  Here we handle the interactions of the user with the cards that     */
    /*  populate the collection view.                                       */
    /************************************************************************/
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
        
        // If a card is selected while there are two cards being worked with, or
        // if a card that is already flipped over is selected...
        if ( (self.model?.numFlippedCards)! > 1 || (self.model?.matchedCardIndexPathes.contains(indexPath))! ) {
            // we return out of function
            return
        }
        //  If this is the first of two cards to be flipped
        else if ( self.model?.numFlippedCards == 0 ) {
            // flip the card
            cell.flipCard()
            //  add the indexPath as an IndexPath and an Int representing the indexPath.item
            self.model?.indexPaths.append(indexPath)
            self.model?.flipCheckIndexes.append(indexPath.item)
            //  increase the number of flipped cards by one.
            self.model?.numFlippedCards+=1
        }
        //  This gets called if now you are flipping the second card
        else if ( self.model?.numFlippedCards == 1 ) {
            //  increase to 2 cards flipped
            self.model?.numFlippedCards+=1
            //  add the indedPath and indexPath.item as int
            self.model?.indexPaths.append(indexPath)
            self.model?.flipCheckIndexes.append(indexPath.item)
            //  flip the card
            cell.flipCard()
            // Now check to see if you have a pair
            checkCards()
            self.model?.indexPaths.removeAll(keepingCapacity: true)
        }
        else {
            return
        }
    }
    //  Here we check to see if there is a pair
    func checkCards () {
        // If the two cards are the same....
        if ( self.model?.userCardDeck[(self.model?.flipCheckIndexes[0])!]?.cardFrontImageName == self.model?.userCardDeck[(self.model?.flipCheckIndexes[1])!]?.cardFrontImageName){
            //  Let user know they found a match.
            self.updateTopLabel(text: "You found a match.")
            
            //  Add the indexPath.
            for indexPath in (self.model?.indexPaths)!{
                self.model?.matchedCardIndexPathes.append(indexPath)
            }
            //  Increment the number of matched pairs
            self.model?.numMatchedPairs+=1
            //  Clear the values for pair matching
            self.model?.numFlippedCards = 0
            self.model?.flipCheckIndexes.removeAll(keepingCapacity: true)
            //  And check to see if they have won.
            checkForWin()
            
        }
        //  Otherwise, use delayedFlip to flip the cards back over, as well as 
        //  to prevent any other cards from being flipped over till the animation
        //  is complete.
        else {
            self.updateTopLabel(text: "  ")
            delayedFlip(indexPath: (self.model?.indexPaths[0])!)
            delayedFlip(indexPath: (self.model?.indexPaths[1])!)
        }
    }
    
    /****************************************************************/
    /*  This is the function to flip the non-matched pairs of       */
    /*  selected cards back over after pause of a few seconds.      */
    /****************************************************************/
    func delayedFlip (indexPath: IndexPath) {
        
        let when = DispatchTime.now() + 2 // 2 = number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            let cell = self.gameCollectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
            cell.flipCard()
            
            self.model?.numFlippedCards = 0
            self.model?.flipCheckIndexes.removeAll(keepingCapacity: true)
        }
    }
    /********************************************************************/
    /*  Here is the function to fade in a string in the top label of    */
    /*  the view.                                                       */
    /********************************************************************/
    func updateTopLabel(text: String){
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {self.topLabel.alpha = 0.0 }, completion: {
            (finished: Bool) -> Void in
            self.topLabel.text = text
        
            //Fade in
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                let tempVal : CGFloat = 1.0
                    self.topLabel.alpha = tempVal
                }, completion: nil)
        })
    }
    /********************************************************************/
    /*  Function to reset game values before a new game.                */
    /********************************************************************/
    func setUpGameBoard() {
        topLabel.text = model?.userGameType.rawValue
        self.layout = MemoryCollectionViewFlowLayout()
        self.layout?.setNumColumns(gameType: (self.model?.userGameType)!)
        gameCollectionView.collectionViewLayout = self.layout!
        self.model?.userCardDeck.shuffle()
        gameCollectionView.reloadData()
        self.topLabel.text = ""
        self.model?.numMatchedPairs = 0
        self.model?.flipCheckIndexes.removeAll()
        self.model?.numFlippedCards = 0
        self.model?.matchedCardIndexPathes.removeAll()
        
    }
    /********************************************************************/
    /*  Function to check to see if user has won the game.              */
    /********************************************************************/
    func checkForWin () {
        if ( self.model?.numPairsForWin == self.model?.numMatchedPairs ){
            let alert = UIAlertController.init(title: "Congratulations!", message: "You matched all the cards.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { action in self.setUpGameBoard() }))
            self.present(alert, animated: true, completion:nil)
        }
    }
    
}
