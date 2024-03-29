//
//  SetGameViewController.swift
//  SetGame
//
//  Created by Sabri Sönmez on 10/7/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit


class ViewController: UIViewController
{

    @IBOutlet weak var startDeck: UIImageView!
    
    @IBOutlet weak var endDeck: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var cardContainerView: CardContainerView!
     var game = Set()
    private var hintedCard = [Card]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
           startDeck.isUserInteractionEnabled = true
           startDeck.addGestureRecognizer(tapGestureRecognizer)
        
        updateViewFromModel()
    }
    
    func updateViewFromModel()
    {
        for view in self.cardContainerView.subviews {
            view.removeFromSuperview()
        }
        for index in game.cardsInGame.indices{
            let subView = SetCardView()
            subView.color = game.cardsInGame[index].color
            subView.count = game.cardsInGame[index].number
            subView.shade = game.cardsInGame[index].shade
            subView.shape = game.cardsInGame[index].shape
            subView.isMatched = game.cardsInGame[index].isMatched
            subView.isSelected = game.cardsInGame[index].isSelected
            subView.isMisMatched = game.cardsInGame[index].isMisMatched
            //subView.isFaceUp =  game.cardsInGame[index].isFaceUp
            subView.isFaceUp =  true
            cardContainerView.isAnimated = true
            cardContainerView.addSubview(subView)
        }
        for view in self.cardContainerView.subviews {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getIndex(_:)))
            view.addGestureRecognizer(gestureRecognizer)
            view.frame = self.startDeck.frame
        }
        
        scoreLabel.text = "Score: \(game.score)"
        matchLabel.isHidden = true
    }
    
    func updateViewFromModel_DealMore()
    {
        for index in (game.cardsInGame.count - 3)...game.cardsInGame.count - 1
        {
            let subView = SetCardView()
            subView.color = game.cardsInGame[index].color
            subView.count = game.cardsInGame[index].number
            subView.shade = game.cardsInGame[index].shade
            subView.shape = game.cardsInGame[index].shape
            subView.isMatched = game.cardsInGame[index].isMatched
            subView.isSelected = game.cardsInGame[index].isSelected
            subView.isMisMatched = game.cardsInGame[index].isMisMatched
            //subView.isFaceUp =  game.cardsInGame[index].isFaceUp
            subView.isFaceUp =  true
            
            cardContainerView.addSubview(subView)
            cardContainerView.isAnimated = true
             subView.frame = self.startDeck.frame
        }
        for view in self.cardContainerView.subviews {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getIndex(_:)))
            view.addGestureRecognizer(gestureRecognizer)
           
        }
        
        scoreLabel.text = "Score: \(game.score)"
        matchLabel.isHidden = true
    }
    
    func updateViewFromModel_Match()
    {
        for view in self.cardContainerView.subviews {
            view.removeFromSuperview()
        }
        
        for index in game.cardsInGame.indices
        {
            let subView = SetCardView()
            subView.color = game.cardsInGame[index].color
            subView.count = game.cardsInGame[index].number
            subView.shade = game.cardsInGame[index].shade
            subView.shape = game.cardsInGame[index].shape
            subView.isMatched = game.cardsInGame[index].isMatched
            subView.isSelected = game.cardsInGame[index].isSelected
            subView.isMisMatched = game.cardsInGame[index].isMisMatched
            //subView.isFaceUp =  game.cardsInGame[index].isFaceUp
            subView.isFaceUp =  true
            
            cardContainerView.isAnimated = false
            cardContainerView.addSubview(subView)
            //subView.frame = self.startDeck.frame
        }
        for view in self.cardContainerView.subviews {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getIndex(_:)))
            view.addGestureRecognizer(gestureRecognizer)
        }
        
        scoreLabel.text = "Score: \(game.score)"
        matchLabel.isHidden = true
    }
    
    @objc func getIndex(_ sender: UITapGestureRecognizer)
    {
        
        if let cardNumber = cardContainerView.subviews.firstIndex(of: sender.view!)
            
        {
            let view = cardContainerView.subviews[cardNumber]
            
            //game.chooseCard(at: cardNumber)
            
            if game.cardsInGame[cardNumber].isSelected
            {
                game.cardsInGame[cardNumber].isSelected = !game.cardsInGame[cardNumber].isSelected
                
                for card in game.selectedTrio.indices
                {
                   // var cardIndex = game.selectedTrio.index(card, offsetBy: 0)
                    if game.selectedTrio.indices.contains(card){
                        if game.cardsInGame[cardNumber].description == game.selectedTrio[card].description
                        {
                            //print(card)
                            game.selectedTrio.remove(at: card)
                            
                        }
                    }
                }
                
                
                UIView.transition(with: view, duration: 0.6, options: .transitionCrossDissolve, animations: {
                    
                    // animation
                    //self.game.cardsInGame[cardNumber].isFaceUp = !self.game.cardsInGame[cardNumber].isFaceUp
                    
                    view.transform = CGAffineTransform(scaleX: 3, y: 3)
                    
                    view.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                   // view.layer.borderWidth = 2
                    
                    
                }) { finished in
                    // completion
                }
            }
            else{
                game.chooseCard(at: cardNumber)
                
                UIView.transition(with: view, duration: 0.6, options: .transitionFlipFromLeft, animations: {
                    
                    // animation
                    //self.game.cardsInGame[cardNumber].isFaceUp = !self.game.cardsInGame[cardNumber].isFaceUp
                    
                    view.transform = CGAffineTransform(scaleX: 2, y: 2)
                    
                    view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    view.layer.borderWidth = 2
                    
                    
                }) { finished in
                    
                    // completion
                    
                }
                
                if(game.cardsInGame[cardNumber].isMisMatched){
                    
                    view.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                    view.layer.borderWidth = 2
                    
                    for view in cardContainerView.subviews {
                        if view.layer.borderColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view.layer.borderWidth == 2
                        {
                            view.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                            view.layer.borderWidth = 2
                            
                            let animation = CABasicAnimation(keyPath: "position")
                            animation.duration = 0.07
                            animation.repeatCount = 4
                            animation.autoreverses = true
                            animation.fromValue = NSValue(cgPoint: CGPoint(x: view.center.x - 10, y: view.center.y))
                            animation.toValue = NSValue(cgPoint: CGPoint(x: view.center.x + 10, y: view.center.y))
                            view.layer.add(animation, forKey: "position")
                        }
                    }
                    
                    self.matchLabel.isHidden = false
                    self.matchLabel.text = "Mismatch! -1"
                    self.matchLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                        self.game.cardsInGame[cardNumber].isMisMatched = false
                        for i in 0..<self.game.cardsInGame.count{
                            self.game.cardsInGame[i].isSelected = false
                        }
                        self.updateViewFromModel_Match()
                    })
                }
                
                if(game.cardsInGame[cardNumber].isMatched)
                {
                    view.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    view.layer.borderWidth = 2
                    
                    for view in cardContainerView.subviews {
                        if view.layer.borderColor == #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), view.layer.borderWidth == 2
                        {
                            view.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                            view.layer.borderWidth = 2
                            
                            
                        }
                    }
                    
                    self.matchLabel.isHidden = false
                    self.matchLabel.text = "Match! +3"
                    self.matchLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
                        
                        self.game.cardsInGame[cardNumber].isMatched = false
                        var numArray = [Int]()
                        
                        for view in self.cardContainerView.subviews {
                            if view.layer.borderColor == #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), view.layer.borderWidth == 2
                            {
                                //print(self.cardContainerView.subviews.firstIndex(of: view)!)
                                numArray.append(self.cardContainerView.subviews.firstIndex(of: view)!)
                                numArray = numArray.sorted().reversed()
                                
                            }
                        }
                        
                        for i in numArray
                        {
                            
                            let view = self.cardContainerView.subviews[i]
                            
                            UIView.transition(with: view, duration: 0.33, options: .transitionFlipFromLeft, animations: {
                                
                                // animation
                                self.game.cardsInGame[i].isFaceUp = !self.game.cardsInGame[i].isFaceUp
                                view.frame = self.endDeck.frame
                                //
                            }) { finished in
                                
                                self.game.cardsInGame.remove(at: i)
                                view.removeFromSuperview()
                            }
                        }
                        
                        self.game.addCards(numberOfCardsToAdd: 3)
                        self.updateViewFromModel_DealMore()
                        
                    })
                }
            }
            
           
        }
    }
    
    @IBAction func newGameClicked(_ sender: Any)
    {
        game.newGame()
        updateViewFromModel()
    }
    
    @IBAction func dealMoreClicked(_ sender: Any)
    {
        if game.cards.count > 1
        {
            game.addCards(numberOfCardsToAdd: 3)
                  updateViewFromModel_DealMore()
        }
      
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
      {
          cardContainerView.isAnimated = true
           if game.cards.count > 1
                 {
                     game.addCards(numberOfCardsToAdd: 3)
                           updateViewFromModel_DealMore()
                 }
      }
    
    @IBAction func hintClicked(_ sender: Any) {
        
        game.hint()
        cardContainerView.isAnimated = true
        if game.hintCard.count < 3 { return }
        
        for index in 0...2 {
        
            hintedCard.append(game.cardsInGame[game.hintCard[index]])
           // print(game.hintCard[index])
            
            let view = cardContainerView.subviews[game.hintCard[index]]
                
            UIView.animate(withDuration: 0.7,
                           animations: {
                            view.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
                           completion: { _ in
                            UIView.animate(withDuration: 0.7) {
                               view.transform = CGAffineTransform.identity
                            }
            })
        }
        hintedCard.removeAll()
        
    }
}
