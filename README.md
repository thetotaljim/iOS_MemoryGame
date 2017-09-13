# Memory iOS Game Application

[![forthebadge](http://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)
[![Awesome Badges](https://img.shields.io/badge/badges-awesome-green.svg)](https://github.com/Naereen/badges)
[![HitCount](http://hits.dwyl.io/thetotaljim/iOS_Memory_Game.svg)](http://hits.dwyl.io/thetotaljim/iOS_Memory_Game)

> This is a Memory Game Application written in Swift.  

This project was developed using a test driven software development process. The file structure follows Apple's Model-View-Controller communication pattern.  

![Picture](https://github.com/thetotaljim/iOS_MemoryGame/blob/master/Assets/memWin.png)

## Requirements

Xcode and Apple Developer Account

## Installation

To use this application, download the repository, and open in Xcode.  

## Usage Example

The game begins with a homepage where you select the size of the game board:

![Picture](https://github.com/thetotaljim/iOS_MemoryGame/blob/master/Assets/memHome.png)

Then you select two cards at a time.  If they are a match, text alerts you to your correct selection.

![Picture](https://github.com/thetotaljim/iOS_MemoryGame/blob/master/Assets/mem1.png)
![Picture](https://github.com/thetotaljim/iOS_MemoryGame/blob/master/Assets/mem2.png)

If the selection is incorrect, the cards flip back over and you have to keep trying. While the card flipping animation is occuring, you are prevented from selecting more cards. Once the animation is over, you can keep playing. When you finish, a pop up informs you of your win, and allows you to reset the game.  You can go back to the home page at anytime by using the back button at the top of the application.

## Contents 

Here is a list of the included files and their usage in this project (located in the main HMan folder):
* Models
  * ``` InitialModel.swift ```
    * Used to determine the the user's selected difficulty 
  * ``` GameModel.swift ```
    * Here the game is played. Functions for selecting words and tracking the progress of each turn are included in this file.
  * ``` FinalModel.swift ```
    * This file displays the results of the game.
  * ``` MyPropertyList.plist ```
    * Contains the words to be guessed.
* Views  
  * ``` HangmanView.swift ```
    * This file uses iOS Core Graphics to draw the hangman.
  * ``` TitleView.swift ```
    * Displays the home page of the application.
* Controllers
  * ``` InitialViewController.swift ```
    * Handles user input of difficult level.
  * ``` GameViewController.swift ```
    * Controls letter selection and seques to initial and final views.
  * ``` FinalViewController.swift ```
    * This View handles how the results are displayed.
 
## Meta

Jim Steimel [@jimsteimel](https://twitter.com/jimsteimel) - jim@thetotaljim.com - www.thetotaljim.com
