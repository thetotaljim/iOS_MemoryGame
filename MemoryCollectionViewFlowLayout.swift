//
//  MemoryCollectionViewFlowLayout.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/28/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

class MemoryCollectionViewFlowLayout: UICollectionViewFlowLayout {

    /****************************************************/
    /*  We add the setupLayout() method to the parent   */
    /*  class initializer to do some extra formatting   */
    /*  based on the user's game type.                  */
    /****************************************************/
    override init() {
        super.init()
        setupLayout()
    }
    /****************************************************/
    /*  required init for subclassing                   */
    /*  UICollectionViewFlowLayout                      */
    /****************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    /****************************************************/
    /*  Set up spacing for the collection view          */
    /****************************************************/
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
    }
    
    /********************************************************/
    /*  The number of columns, along with the size of the   */
    /*  collection view in the window will be used to       */
    /*  set the size of collection view items and the       */
    /*  number of columns for the different games.          */
    /********************************************************/
    var numColumns : CGFloat = 4
    
    func setNumColumns(gameType: GameType){
        if(gameType == GameType.TwoByTwo){
            numColumns = 2
        }
        else if(gameType == GameType.SixBySix){
            numColumns = 6
        }
        else {
            numColumns = 4
        }
    }
    /*********************************************************/
    /*  Here we modify the itemSize that will be returned.   */
    /*********************************************************/
    override var itemSize: CGSize {
        //  Needed for mutable property
        set {
            
        }
        get {
            let numberOfColumns: CGFloat = numColumns
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1)) / numberOfColumns

            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
}
