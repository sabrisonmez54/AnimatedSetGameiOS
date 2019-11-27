//
//  Card.swift
//  SetGame
//
//  Created by Sabri Sönmez on 10/7/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import Foundation
import UIKit

struct Card
{
    internal var color : Colors
    internal var shade : Shades
    internal var shape : Shapes
    internal var number : Numbers
    
    
    internal var isMatched = false
    internal var isMisMatched = false
    internal var isSelected = false
    
    var description: String {
        return "\(color)\(shade),\(shape)"
    }
    
    enum Numbers
    {
        case one
        case two
        case three
        static var all = [Numbers.one, Numbers.two, Numbers.three]
    }
    
    enum Colors
    {
        case purple
        case green
        case red
        static var all = [Colors.purple, Colors.green, Colors.red]
    }
    
    enum Shades
    {
        case empty
        case filled
        case striped
        static var all = [Shades.empty, Shades.filled, Shades.striped]
    }
    
    enum Shapes
    {
        case diamond
        case squiggle
        case ellipse
        static var all = [Shapes.diamond, Shapes.squiggle, Shapes.ellipse]
    }
    
//    func cardFace() -> String
//    {
//    var shape : String
//    var number : Int
//
//    switch(self.number)
//        {
//        case .one:
//            number = 1
//        case .two:
//            number = 2
//        case .three:
//            number = 3
//        }
//
//    switch(self.shape)
//    {
//    case .triangle:
//        shape = "▲"
//    case .circle:
//        shape = "⬤"
//    case .square:
//        shape = "■"
//        }
//        var numOfShape = ""
//        for _ in 1...number
//        {
//            numOfShape += shape
//
//        }
//
//    return numOfShape
//
//    }
//
//    func attributedContents() -> NSAttributedString {
//
//        var strokeColor : UIColor
//
//        switch (self.color) {
//        case .purple:
//            strokeColor = UIColor.purple
//        case .green:
//            strokeColor = UIColor.green
//        case .red:
//            strokeColor = UIColor.red
//        }
//
//        var shadingColor = strokeColor
//
//        switch (self.shade) {
//        case .empty:
//            shadingColor = shadingColor.withAlphaComponent(0.0)
//        case .striped:
//            shadingColor = shadingColor.withAlphaComponent(0.2)
//        case .filled:
//            shadingColor = shadingColor.withAlphaComponent(1.0)
//        }
//
//        let attributes : [NSAttributedString.Key: Any] = [.strokeColor : strokeColor, .foregroundColor : shadingColor, .strokeWidth : -5.0 ]
//
//        let attribtext = NSAttributedString(string: self.cardFace(), attributes: attributes)
//
//        return attribtext
//    }
    
}
