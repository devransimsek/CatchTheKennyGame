//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by devran simsek on 31.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    var score = 0;
    var counter = 0;
    var kennyArray = [UIImageView]()
    var highScore = 0
    
    var timer = Timer()
    var kennyTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scoreLabel.text = "Score: \(score)";
        
        // High Score Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
            highScore = 0;
            highScoreLabel.text = "High Score: 0"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore;
            highScoreLabel.text = "High Score: \(newScore)"
        }
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        
        kennyArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
        
        //Timers
        counter = 10;
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTime), userInfo: nil, repeats: true)
        kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:
                                            #selector(hideOrShowKenny), userInfo: nil, repeats: true)
        hideOrShowKenny()
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)";
    }
    
    @objc func decreaseTime() {
        counter -= 1;
        timeLabel.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            kennyTimer.invalidate()
            
            //High Score
            
            if self.score > self.highScore {
                self.highScore = self.score;
                highScoreLabel.text = "High Score: \(self.highScore)";
                UserDefaults.standard.set(self.highScore ,forKey: "highScore");
            }
            
            for kenny in kennyArray {
                kenny.isHidden = true;
            }
            //Alert
            let alertMessage = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert);
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil);
            let replayButtton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                // replay function
                self.score = 0;
                self.scoreLabel.text = "Score: \(self.score)";
                self.counter = 10;
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseTime), userInfo: nil, repeats: true)
                self.kennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:
                                                        #selector(self.hideOrShowKenny), userInfo: nil, repeats: true)
            }
            
            alertMessage.addAction(okButton)
            alertMessage.addAction(replayButtton)
            self.present(alertMessage, animated: true, completion: nil);
        }
    }
    
    @objc func hideOrShowKenny() {
        for kenny in kennyArray {
            kenny.isHidden = true;
        }
        
        let random  = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false;
    }

}

