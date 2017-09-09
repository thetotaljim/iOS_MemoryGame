//
//  ViewController.swift
//  MemoryGameProject2
//
//  Created by James Steimel on 10/27/16.
//  Copyright © 2016 James Steimel. All rights reserved.
//

import UIKit

/************************************************/
/*  This is an enum to use for the different    */
/*  board sizes that a user might choose.       */
/************************************************/
enum GameType : String {
    
    case TwoByTwo
    case FourByFour
    case SixBySix
}
class MainViewController: UIViewController {
    
    /************************************************************/
    /*  Here are the elements of the Main View                  */
    /************************************************************/
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var buttonDescriptionLabel: UILabel!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    
    /************************************************************/
    /*  Here button presses are handled.                        */
    /************************************************************/
    
    @IBAction func twoButtonPressed(_ sender: AnyObject) {
        fourButton.isEnabled = false
        sixButton.isEnabled = false
        model?.userGameType = GameType.TwoByTwo
        self.performSegue(withIdentifier: "MoveToGame", sender: self)
    }
    @IBAction func fourButtonPressed(_ sender: AnyObject) {
        twoButton.isEnabled = false
        sixButton.isEnabled = false
        model?.userGameType = GameType.FourByFour
        self.performSegue(withIdentifier: "MoveToGame", sender: self)
    }
    @IBAction func sixButtonPressed(_ sender: AnyObject) {
        twoButton.isEnabled = false
        fourButton.isEnabled = false
        model?.userGameType = GameType.SixBySix
        self.performSegue(withIdentifier: "MoveToGame", sender: self)
    }
    //  The model variable.     //
    var model: MainModel?
    
    override func viewDidLoad() {
        self.model = MainModel()
    }
    /********************************************************************/
    /*  When a button is pressed, the user's game type value will be    */
    /*  passed to the GameModel for use by the GameViewController       */
    /********************************************************************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //  Enable the buttons before transitioning.    //
        twoButton.isEnabled = true
        fourButton.isEnabled = true
        sixButton.isEnabled = true
        
        if segue.identifier == "MoveToGame" {
            if let destination = segue.destination as? GameViewController {
                let gameType : GameType = model!.userGameType!
                let gameModel = GameModel(gameType: gameType)
                destination.model = gameModel
            }
        }
    }


}

