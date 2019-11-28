//
//  SetCardView.swift
//  Diamond
//
//  Created by Sameh Fakhouri on 10/28/19.
//  Copyright © 2019 Sameh Fakhouri. All rights reserved.
//

import UIKit

@IBDesignable class SetCardView: UIView {

    
    /***********************************************************/
    /*                                                         */
    /*  Properties                                             */
    /*                                                         */
    /***********************************************************/
 
    
    var color : Card.Colors = Card.Colors.green {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    enum Shapes {
        case diamond
        case ellipse
        case squigle
        
        static var all = [Shapes.diamond, Shapes.ellipse, Shapes.squigle]
    }
    
    var shape : Card.Shapes = Card.Shapes.diamond {
        didSet{
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
  

    
    var shade : Card.Shades = Card.Shades.empty {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    


    var count : Card.Numbers = Card.Numbers.one {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    
    @IBInspectable var isSelected: Bool = true {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var isMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var isMisMatched: Bool = false {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    @IBInspectable var isFaceUp: Bool = true  {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    

    /***********************************************************/
    /*                                                         */
    /* Draw Diamonds                                           */
    /*                                                         */
    /***********************************************************/
    private func drawDiamond() -> UIBezierPath {
        let diamond = UIBezierPath()
        
        diamond.move(to: upperVertex)
        diamond.addLine(to: rightVertex)
        diamond.addLine(to: lowerVertex)
        diamond.addLine(to: leftVertex)
        diamond.addLine(to: upperVertex)
        diamond.close()
        
        return diamond
    }
    /***********************************************************/
    /*                                                         */
    /* Draw Ellipse                                          */
    /*                                                         */
    /***********************************************************/
    private func drawEllipse() -> UIBezierPath {
        let ellipse = UIBezierPath()
        
        ellipse.move(to: lowerLeftVertex)
        //ellipse.addLine(to: upperRightVertex)
        
        //ellipse.addLine(to: lowerRightVertex)
        ellipse.addLine(to: upperLeftVertex)
        
        let xDistance = (upperRightVertex.x - upperLeftVertex.x)
        let yDistance = (upperRightVertex.y - upperLeftVertex.y)
        let distance = sqrt((xDistance * xDistance) + (yDistance * yDistance))
    
        ellipse.addArc(withCenter: CGPoint(x: self.bounds.size.width * 0.5,y: self.bounds.size.height * 0.3), radius: distance/2, startAngle: .pi, endAngle: 0, clockwise: true)
        
        ellipse.addLine(to: lowerRightVertex)
        ellipse.addArc(withCenter: CGPoint(x: self.bounds.size.width * 0.5,y: self.bounds.size.height / 1.5), radius: distance/2, startAngle: 0, endAngle: .pi, clockwise: true)
        
        ellipse.close()
        
        
        return ellipse
    }
    
    /***********************************************************/
    /*                                                         */
    /* Draw Squigle                                             */
    /*                                                         */
    /***********************************************************/
    
    private func drawSquigle() -> UIBezierPath {
        let squigle = UIBezierPath()
        let upperCenterCG = CGPoint(x: self.bounds.size.width * 0.52, y: self.bounds.size.height * 0.1)
        let lowerCenterCG = CGPoint(x: self.bounds.size.width * 0.52, y: self.bounds.size.height / 1.2)
        
        squigle.move(to: lowerLeftVertex)
        squigle.addCurve(to: upperLeftVertex, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        squigle.addQuadCurve(to: upperRightVertex, controlPoint: upperCenterCG)
        squigle.addCurve(to: lowerRightVertex, controlPoint1: controlPoint4, controlPoint2: controlPoint3)
        squigle.addQuadCurve(to: lowerLeftVertex, controlPoint: lowerCenterCG)
        squigle.close()
        
        
        return squigle
    }
    /***********************************************************/
    /*                                                         */
    /* Show Path                                               */
    /*                                                         */
    /***********************************************************/
    private func showPath(_ path: UIBezierPath) {
        var path = replicatePath(path)
        colorForPath.setStroke()
        path = shadePath(path)
        path.lineWidth = 2.0
        path.stroke()
        path.fill()
    }
    
    /***********************************************************/
    /*                                                         */
    /* Color Path                                              */
    /*                                                         */
    /***********************************************************/
    private var colorForPath: UIColor {
        switch color {
        case .green: return UIColor.green
        case .red: return UIColor.red
        case .purple: return UIColor.purple
        }
    }
    
    /***********************************************************/
    /*                                                         */
    /* Shade Path                                              */
    /*                                                         */
    /***********************************************************/
    private func shadePath(_ path: UIBezierPath) -> UIBezierPath {
        let shadedPath = UIBezierPath()
        shadedPath.append(path)
        
        switch shade {
        case .filled:
            colorForPath.setFill()
        case .striped:
            UIColor.clear.setFill()
            shadedPath.addClip()
            var start = CGPoint(x:0.0, y:0.0)
            var end = CGPoint(x: self.bounds.size.width, y: 0.0)
            let dy: CGFloat = self.bounds.height / 10.0
            while start.y <= self.bounds.height {
                shadedPath.move(to: start)
                shadedPath.addLine(to: end)
                start.y += dy
                end.y += dy
            }
        case .empty:
            UIColor.clear.setFill()
        }
        
        return shadedPath
    }
    
    /***********************************************************/
    /*                                                         */
    /* Show Path                                               */
    /*                                                         */
    /***********************************************************/
    private func replicatePath(_ path: UIBezierPath) -> UIBezierPath {
        let replicatedPath = UIBezierPath()
        
        if count == .one {
            replicatedPath.append(path)
        } else if count == .two {
            let leftPath = UIBezierPath()
            leftPath.append(path)
            let leftPathTransform = CGAffineTransform(
            translationX: leftTwoPathTranslation.x, y: leftTwoPathTranslation.y)
            leftPath.apply(leftPathTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path)
            let rightPathTransform = CGAffineTransform(
            translationX: rightTwoPathTranslation.x, y: rightTwoPathTranslation.y)
            rightPath.apply(rightPathTransform)
            
            replicatedPath.append(leftPath)
            replicatedPath.append(rightPath)
        } else if count == .three {
            let leftPath = UIBezierPath()
            leftPath.append(path)
            let leftPathTransform = CGAffineTransform(
                translationX: leftThreePathTranslation.x, y: leftThreePathTranslation.y)
            leftPath.apply(leftPathTransform)
            
            let rightPath = UIBezierPath()
            rightPath.append(path)
            let rightPathTransform = CGAffineTransform(
                translationX: rightThreePathTranslation.x, y: rightThreePathTranslation.y)
            rightPath.apply(rightPathTransform)
            
            replicatedPath.append(leftPath)
            replicatedPath.append(path)
            replicatedPath.append(rightPath)
        }
        
        return replicatedPath
    }
    
    
    /***********************************************************/
    /*                                                         */
    /* draw                                                    */
    /*                                                         */
    /***********************************************************/
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        
        if isSelected {
            roundedRect.lineWidth = 5.0
            UIColor.black.setStroke()
        } else if isMatched {
            roundedRect.lineWidth = 5.0
            UIColor.green.setStroke()
        } else if isMisMatched {
            roundedRect.lineWidth = 5.0
            UIColor.red.setStroke()
        } else {
            roundedRect.lineWidth = 5.0
            UIColor.white.setStroke()
        }
        
        UIColor.white.setFill()
        roundedRect.fill()
        roundedRect.stroke()
        
        let path = UIBezierPath()
        if !isFaceUp {
            if let cardBackImage = UIImage(named: "cardback",
                                           in: Bundle(for: self.classForCoder),
                                           compatibleWith: traitCollection) {
                cardBackImage.draw(in: bounds)
                
            }
        }
        if isFaceUp {
            if(shape == .diamond){
                path.append(drawDiamond())
            }
            if(shape == .ellipse){
                path.append(drawEllipse())
            }
            if(shape == .squiggle){
                path.append(drawSquigle())
            }
        }
     
        showPath(path)
    }
}

extension SetCardView {
    /***********************************************************/
    /*                                                         */
    /* Corner Radius                                           */
    /*                                                         */
    /***********************************************************/
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * 0.06
    }
}

extension SetCardView {
    /***********************************************************/
    /*                                                         */
    /* Diamond Constants                                       */
    /*                                                         */
    /***********************************************************/
    
    private struct DiamondRatios {
        static let upperVertexOffsetPercentage:  CGFloat = 0.10
        static let lowerVertexOffsetPercentage:  CGFloat = 0.10
        static let widthPercentage:              CGFloat = 0.20
    }
    
    private var upperVertex: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0,
                       y: self.bounds.size.height * DiamondRatios.upperVertexOffsetPercentage)
    }
    
    private var lowerVertex: CGPoint {
        return CGPoint(x: self.bounds.width/2.0,
                       y: self.bounds.height - (self.bounds.size.height * DiamondRatios.lowerVertexOffsetPercentage))
    }
    
    private var leftVertex: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - (self.bounds.size.width * DiamondRatios.widthPercentage / 2.0),
                       y: self.bounds.size.height/2.0)
    }
    
    private var rightVertex: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + (self.bounds.size.width * DiamondRatios.widthPercentage / 2.0),
                       y: self.bounds.size.height/2.0)
    }
    /***********************************************************/
    /*                                                         */
    /* Ellipse Constants                                       */
    /*                                                         */
    /***********************************************************/
    private var upperLeftVertex: CGPoint {
        return CGPoint(x: self.bounds.size.width / 2.0 - self.bounds.size.width / 12.0,
                       y: self.bounds.size.height * 0.3)
    }
    
    
    private var lowerLeftVertex: CGPoint {
        return CGPoint(x:self.bounds.size.width / 2.0 - self.bounds.size.width / 12.0 ,
                       y: self.bounds.size.height / 1.5);
    }
    
    private var upperRightVertex: CGPoint {
        return CGPoint(x: self.bounds.size.width / 2.0 + self.bounds.size.width / 12.0,
                       y: self.bounds.size.height * 0.3)
    }
    
    
    private var lowerRightVertex: CGPoint {
        return CGPoint(x:self.bounds.size.width / 2.0 + self.bounds.size.width / 12.0 ,
                       y: self.bounds.size.height / 1.5);
    }
    
    /***********************************************************/
    /*                                                         */
    /* Squigle Constants                                       */
    /*                                                         */
    /***********************************************************/
    private var controlPoint1: CGPoint {
        return CGPoint(x: self.bounds.size.width / 2.0 - self.bounds.size.width / 6.0,
                       y: self.bounds.size.height * 0.5)
    }
    
    
    private var controlPoint2: CGPoint {
        return CGPoint(x:self.bounds.size.width / 2.0 + self.bounds.size.width / 18.0 ,
                       y: self.bounds.size.height / 2.2);
    }
    
    private var controlPoint3: CGPoint {
        return CGPoint(x: self.bounds.size.width / 2.0 - self.bounds.size.width / 18.0,
                       y: self.bounds.size.height * 0.5)
    }
    
    
    private var controlPoint4: CGPoint {
        return CGPoint(x:self.bounds.size.width / 2.0 + self.bounds.size.width / 6.0 ,
                       y: self.bounds.size.height / 2.2);
    }
    
}

extension SetCardView {
    /***********************************************************/
    /*                                                         */
    /* Path Replication Constants                              */
    /*                                                         */
    /***********************************************************/
    
    private var leftTwoPathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * -0.15,
                       y: 0.0)
    }
    
    private var rightTwoPathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * 0.15,
                       y: 0.0)
    }
    
    private var leftThreePathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * -0.25,
                       y: 0.0)
    }
    
    private var rightThreePathTranslation: CGPoint {
        return CGPoint(x: self.bounds.size.width * 0.25,
                       y: 0.0)
    }
}

