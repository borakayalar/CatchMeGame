//
//  ViewController.swift
//  CatchMeGame
//
//  Created by Bora Kayalar on 6.03.2020.
//  Copyright © 2020 New Generation Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var meArray = [UIImageView]()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!

    @IBOutlet weak var me1: UIImageView!
    @IBOutlet weak var me2: UIImageView!
    @IBOutlet weak var me3: UIImageView!
    @IBOutlet weak var me4: UIImageView!
    @IBOutlet weak var me5: UIImageView!
    @IBOutlet weak var me6: UIImageView!
    @IBOutlet weak var me7: UIImageView!
    @IBOutlet weak var me8: UIImageView!
    @IBOutlet weak var me9: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score : \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highscoreLabel.text = "Highscore: \(highScore)"
        }
        

        
        me1.isUserInteractionEnabled = true
        me2.isUserInteractionEnabled = true
        me3.isUserInteractionEnabled = true
        me4.isUserInteractionEnabled = true
        me5.isUserInteractionEnabled = true
        me6.isUserInteractionEnabled = true
        me7.isUserInteractionEnabled = true
        me8.isUserInteractionEnabled = true
        me9.isUserInteractionEnabled = true
        
        meArray = [me1,me2,me3,me4,me5,me6,me7,me8,me9] //me objeleri meArray e yüklendi
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
                
        for me in meArray {
            me.isUserInteractionEnabled = true
        }
 
        me1.addGestureRecognizer(recognizer1)
        me2.addGestureRecognizer(recognizer2)
        me3.addGestureRecognizer(recognizer3)
        me4.addGestureRecognizer(recognizer4)
        me5.addGestureRecognizer(recognizer5)
        me6.addGestureRecognizer(recognizer6)
        me7.addGestureRecognizer(recognizer7)
        me8.addGestureRecognizer(recognizer8)
        me9.addGestureRecognizer(recognizer9)
        
        
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(hideMe), userInfo: nil, repeats: true)
        timeLabel.text = "\(counter)"

        


        
    }
    
    @objc func hideMe(){
        
        for me in meArray{
            me.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(meArray.count - 1)))
        meArray[random].isHidden = false
        
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        if counter == 0 {
            
            timer.invalidate()
            hideTimer.invalidate()
            
            for me in meArray {
                me.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highscoreLabel.text = "Highscore: \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Time is up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert )
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {(UIAlertAction) in
                self.counter = 10
                self.score = 0
                self.timeLabel.text = "10"
                self.scoreLabel.text = "0"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector: #selector(self.hideMe), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }


}

