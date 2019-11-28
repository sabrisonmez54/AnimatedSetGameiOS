//
//  CardContainerView.swift
//  SetGame
//
//  Created by Sabri Sönmez on 11/13/19.
//  Copyright © 2019 Sabri Sönmez. All rights reserved.
//

import UIKit

class CardContainerView: UIView
{
    var isAnimated = true
    
    override func layoutSubviews()
    {
        
        
        let grid = Grid(for: self.frame, withNoOfFrames: self.subviews.count, forIdeal: 2.0)
        
        for index in self.subviews.indices{
            if var frame = grid[index]
            {
                frame.size.width -= 5
                frame.size.height -= 5
             
               
                
                var delay = 0.0
                
                if isAnimated
                {
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1,
                                                                   delay: delay,
                                                                   options: [.curveEaseInOut],
                                                                   animations: {
                                                                    self.subviews[index].frame = frame
                                                                    
                                                                    delay += 3.0
                                                                    
                    })
                }else{
                     self.subviews[index].frame = frame
                }
               
                
                
            }
        }
    }
}
