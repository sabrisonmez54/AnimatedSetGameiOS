//
//  CardContainerView.swift
//  SetGame
//
//  Created by Sabri Sönmez on 11/13/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit

class CardContainerView: UIView {
    
    override func layoutSubviews() {
        
        let grid = Grid(for: self.frame, withNoOfFrames: self.subviews.count, forIdeal: 2.0)
        
        for index in self.subviews.indices{
            if var frame = grid[index]
            {
                frame.size.width -= 5
                frame.size.height -= 5
             
                var delay = 0.0
                
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1.0,
                                                               delay: delay,
                                                               options: [.curveEaseInOut],
                                                               animations: {
                     self.subviews[index].frame = frame
                    
                    delay += 3.0
                                                                
                })
                
                
//                UIView.transition(with: self.subviews[index], duration: 1, options: .transitionFlipFromLeft, animations: {
//
//                    // animation
//                       self.subviews[index].frame = frame
//
//                }) { finished in
//
//                    // completion
//
//                }
                
            }
        }
    }
}
