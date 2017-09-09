//
//  GameCollectionViewCell.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/28/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class MemoryCollectionViewCell: UICollectionViewCell {
    /****************************************************/
    /*  The image view for displaying cards.            */
    /****************************************************/
    @IBOutlet weak var imageView: UIImageView!
    
    /****************************************************/
    /*  these are the values that are used to display   */
    /*  the different cards in different cells.         */
    /****************************************************/
    var hasBeenFlipped : Bool = true
    var cardBackImageName : String = "card_backside_blue.png"
    var cardFrontImageName : String = ""
    
    /****************************************************/
    /*  Function that will perform flip animation       */
    /****************************************************/
    func flipCard() {
        UIView.transition(  with: contentView,
                            duration:0.5,
                            options:.transitionFlipFromLeft,
                            animations: {
                                self.imageView?.image = UIImage(named: self.hasBeenFlipped ? self.cardFrontImageName : self.cardBackImageName)
                            },
                            completion: nil)
        
        self.hasBeenFlipped = !self.hasBeenFlipped
    }
}
