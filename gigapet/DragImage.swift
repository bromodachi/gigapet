//
//  DragImage.swift
//  gigapet
//
//  Created by hackintosh on 6/12/16.
//  Copyright © 2016 bromodachi. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {
    var originalPositon: CGPoint!
    
    var dropTarget:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPositon = self.center //the image view
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            print("moving...")
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
            
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            if CGRectContainsPoint(target.frame, position) {
                //if it's anywhere on the moster frame,
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
        }
        self.center  = originalPositon
        
    }
}