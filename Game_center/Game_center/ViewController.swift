//
//  ViewController.swift
//  Game_center
//
//  Created by joão gabriel on 30/11/16.
//  Copyright © 2016 bepid. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController, GKGameCenterControllerDelegate{
    
    @IBOutlet weak var lblScore: UILabel!
    
    var score: Int = 0 // Stores the score
//    
//    var gcEnabled = Bool() // Stores if the user has Game Center enabled
//    var gcDefaultLeaderBoard = String() // Stores the default leaderboardID

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view, typically from a nib.
        

        
        self.authenticateLocalPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticateLocalPlayer() {
        
        GameCenter.authenticateLocalPlayer(view: self)
//        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
//        
//        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
//            if((ViewController) != nil) {
//                // 1 Show login if player is not logged in
//                self.present(ViewController!, animated: true, completion: nil)
//            } else if (localPlayer.isAuthenticated) {
//                // 2 Player is already euthenticated & logged in, load game center
//                self.gcEnabled = true
//                
//                // Get the default leaderboard ID
//                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: {(leaderboardIdentifer: String?, error: Error?) -> Void in
//                    if error != nil {
//                        print(error)
//                    } else {
//                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
//                    }
//                })
//                
//                
//            } else {
//                // 3 Game center is not enabled on the users device
//                self.gcEnabled = false
//                print("Local player could not be authenticated, disabling game center")
//                print(error)
//            }
//            
//        }
        
    }
    
    @IBAction func PlusOne(_ sender: UIButton) {
        
        score += 1
        lblScore.text = "\(score)"
    }
    
    @IBAction func minusOne(_ sender: UIButton) {
        
        score -= 1
        lblScore.text = "\(score)"
    }
    
    @IBAction func submitScore(_ sender: UIButton) {
        
        GameCenter.submitScore(score: score)
//        
//        let leaderboardID = "Treino_classificacao" //Put here the ID what you put in itunes connect.
//        let sScore = GKScore(leaderboardIdentifier: leaderboardID)
//        sScore.value = Int64(score)
//        
//        
//        GKScore.report([sScore], withCompletionHandler: {(error: Error?) -> Void in
//            if error != nil {
//                print(error!.localizedDescription)
//            } else {
//                print("Score submitted")
//                self.teste.updateAchivements()
//                
//            }
//        })
//        
//        self.teste.updateAchivements()
    }
    
//    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
//        gameCenterViewController.dismiss(animated: true, completion: nil)
//    }

    @IBAction func showLeaderboard(_ sender: UIButton) {
        
        GameCenter.showLeaderboard(view: self)
        
//        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
//        gcVC.gameCenterDelegate = self
//        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
//        gcVC.leaderboardIdentifier = "Treino_classificacao"//Put here the ID what you put in itunes connect.
//        self.present(gcVC, animated: true, completion: nil)
    }
    
//    @IBAction func updateAchie(_ sender: UIButton) {
//        
//        
//    }
    
//    func updateAchivements() {
//        
//        var achivementsIndentifier: String = ""
//        var progressPercentage = 0.0
//        var progressInLevelAchievement = false
//        
//        var levelAchievement:GKAchievement? = nil
//        var scoreAchievement:GKAchievement? = nil
//        
//        if(score >= 25){
//            progressPercentage = Double(score * 100 / 25)
//            achivementsIndentifier = "conquista_3"
//            progressInLevelAchievement = true
//        }
//        if (score >= 40) {
//            progressPercentage = Double(score * 100 / 40)
//            achivementsIndentifier = "conquista"
//            progressInLevelAchievement = true
//        }
//        
//        if (progressInLevelAchievement) {
//            levelAchievement = GKAchievement.init(identifier: achivementsIndentifier)
//            
//            levelAchievement?.percentComplete = progressPercentage
//            
//            print(progressPercentage)
//            
//            
//        }
//        
//        scoreAchievement = GKAchievement.init(identifier: achivementsIndentifier)
//        scoreAchievement?.percentComplete = progressPercentage
//        
//        let achivements: Array = progressInLevelAchievement ? [levelAchievement, scoreAchievement] : [scoreAchievement]
//        
//        GKAchievement.report(achivements as! [GKAchievement], withCompletionHandler: {(error: Error?) -> Void in
//            if (error != nil){
//                print(error!)
//            }else{
//                print("\n\n achivementsIndentifier: \(achivementsIndentifier) \n\n")
//            }
//        })
//    }


    @IBAction func resetAction(_ sender: UIButton) {
        
        GameCenter.resetAchievements()
    }
}

