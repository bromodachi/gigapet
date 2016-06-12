//
//  ViewController.swift
//  gigapet
//
//  Created by hackintosh on 6/12/16.
//  Copyright © 2016 bromodachi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: MonsterImage!
    @IBOutlet weak var foogImg: DragImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var penalty1: UIImageView!
    @IBOutlet weak var penalty2: UIImageView!
    @IBOutlet weak var penalty3: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var currPenalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem:UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        foogImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        penalty1.alpha = DIM_ALPHA
        penalty2.alpha = DIM_ALPHA
        penalty3.alpha = DIM_ALPHA
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            musicPlayer.prepareToPlay()
            
            musicPlayer.play()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
        }catch let err as NSError {
            print(err.debugDescription)
        }
        startTimer()
        //monsterImg.animationImages
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func itemDroppedOnCharacter(notification: AnyObject){
        monsterHappy = true
        startTimer()
        
        foogImg.alpha = DIM_ALPHA
        foogImg.userInteractionEnabled = false
        
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        }
        else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate() //stopped the exisitng one
        }
         timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        if !monsterHappy {
            currPenalties++
            sfxSkull.play()
            if currPenalties == 1 {
                penalty1.alpha = OPAQUE
                penalty2.alpha = DIM_ALPHA
                
            }
            else if currPenalties == 2 {
                penalty2.alpha = OPAQUE
                penalty3.alpha = DIM_ALPHA
            }
            else if currPenalties >= 3 {
                penalty3.alpha = OPAQUE
            }
            else{
                penalty1.alpha = DIM_ALPHA
                penalty2.alpha = DIM_ALPHA
                penalty3.alpha = DIM_ALPHA
                
            }
            
            if currPenalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foogImg.alpha = DIM_ALPHA
            foogImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foogImg.alpha = OPAQUE
            foogImg.userInteractionEnabled = true
            
        }
        
        currentItem = rand
        monsterHappy = false
        
    }
    
    func gameOver(){
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
    }
    
    


}

