//
//  MemoryCard.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/28/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class MemoryCard  {
    /************************************************************/
    /*  The MemoryCard class consists of string for the front   */
    /*  and back images of a card, and a bool to represet       */
    /*  whether the card has been flipped or not                */
    /************************************************************/
    var cardBackImageName : String = "card_backside_blue.png"
    var cardFrontImageName : String?
    var hasBeenFlipped : Bool = false
}
