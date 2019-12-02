//
//  Set.swift
//  SetGame
//
//  Created by Sabri Sönmez on 10/7/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import Foundation

struct Set
{
    var cards = [Card]()
    var cardsInGame = [Card]()
    var hintCard = [Int]()
    
    var selectedTrio = [Card]()
    var score = 0
    
    init()
    {
        newGame()
    }
    
    mutating func newGame() {
        score = 0
        cards.removeAll()
        cardsInGame.removeAll()
        selectedTrio.removeAll()
        hintCard.removeAll()
        generateCards()
        addCards(numberOfCardsToAdd: 12)
    }
    
    private mutating func generateCards() {
        for color in Card.Colors.all {
            for shape in Card.Shapes.all{
                for number in Card.Numbers.all{
                    for shade in Card.Shades.all {
                        let playingCard = Card(color: color, shade: shade, shape: shape, number: number, isFaceUp: false, isMatched: false, isMisMatched: false, isSelected: false)
                        cards.append(playingCard)
                        cards.shuffle()
                    }
                }
            }
        }
    }
    
    mutating func hint() {
        hintCard.removeAll()
        for i in 0..<cardsInGame.count {
            for j in (i + 1)..<cardsInGame.count {
                for k in (j + 1)..<cardsInGame.count {
                    let hints = [cardsInGame[i], cardsInGame[j], cardsInGame[k]]
                    if checkMatch(hints) {
                        hintCard += [i, j, k]
                    }
                }
            }
        }
    }
    
    private mutating func addCard()
    {
        let randomInt = Int.random(in: 0..<cards.count)
        let selectedCard = cards.remove(at: randomInt)
        
        cardsInGame.append(selectedCard)
      
    }
    
    mutating func addCards(numberOfCardsToAdd numberOfCards: Int)
    {
        for _ in 0..<numberOfCards
        {
            addCard()
        }
    }
    
    internal mutating func chooseCard(at index: Int)
    {assert(cardsInGame.indices.contains(index), "Concentration.chooseCard(at: \(index)): Chosen index not valid")
        
        if(!cardsInGame[index].isSelected)
        {
            selectedTrio.append(cardsInGame[index])
            
            if(selectedTrio.count == 3), (checkMatch(selectedTrio))
            {
                cardsInGame[index].isMatched = true
                
                selectedTrio.removeAll()
                
                score = score + 3
                
              //  print("MATCH")
                
            }
            
            if selectedTrio.count == 3, !checkMatch(selectedTrio)
            {
                cardsInGame[index].isMisMatched = true
                
                score = score - 1
                    
                selectedTrio.removeAll()
                
              //  print("mismatch")
            }
                
            else
            {
                cardsInGame[index].isSelected = true
               // print("selected less than 3")
            }
        }
    }
    
    func checkMatch(_ selectedCards : [Card]) -> Bool
    {
        if selectedCards.count != 3
        {
            return false
        }
        if selectedCards[0].color == selectedCards[1].color
        {
            if selectedCards[0].color != selectedCards[2].color
            {
                return false
            }
        }
        else if selectedCards[1].color == selectedCards[2].color
        {
            return false
        }
        else if (selectedCards[0].color == selectedCards[2].color)
        {
            return false
        }
        if selectedCards[0].number == selectedCards[1].number
        {
            if selectedCards[0].number != selectedCards[2].number
            {
                return false
            }
        }
        else if selectedCards[1].number == selectedCards[2].number
        {
            return false
        }
        else if (selectedCards[0].number == selectedCards[2].number)
        {
            return false
        }
        if selectedCards[0].shade == selectedCards[1].shade
        {
            if selectedCards[0].shade != selectedCards[2].shade
            {
                return false
            }
        }
        else if selectedCards[1].shade == selectedCards[2].shade
        {
            return false
        }
        else if (selectedCards[0].shade == selectedCards[2].shade)
        {
            return false
        }
        if selectedCards[0].shape == selectedCards[1].shape
        {
            if selectedCards[0].shape != selectedCards[2].shape
            {
                return false
            }
        }
        else if selectedCards[1].shape == selectedCards[2].shape
        {
            return false
        }
        else if (selectedCards[0].shape == selectedCards[2].shape)
        {
            return false
        }
        return true
    }
}

extension Int
{
    var arc4random: Int
    {
        if (self > 0)
        {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if (self < 0)
        {
            return -Int(arc4random_uniform(UInt32(-self)))
        }
        else
        {
            return 0
        }
    }
}
