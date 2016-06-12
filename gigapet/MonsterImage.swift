//
//  MonsterImage.swift
//  gigapet
//
//  Created by hackintosh on 6/12/16.
//  Copyright © 2016 bromodachi. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation(){
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        startAnimation("idle")
    }
    
    func playDeathAnimation(){
        self.animationImages = nil
        self.image = UIImage(named: "dead5.png")
        startAnimation("dead")
        
        
    }
    
    func startAnimation(nameOfImage: String){
        var imgArray = [UIImage]()
        for var x = 1; x<5 ; x++ {
            let img = UIImage(named: nameOfImage+"\(x).png")
            imgArray.append(img!)
        }
        
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = nameOfImage == "idle"  ? 0 : 1 // infinite
        self.startAnimating()
    }
}