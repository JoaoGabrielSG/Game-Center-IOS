//
//  GameCenter.swift
//  Game_center
//
//  Created by joão gabriel on 07/12/16.
//  Copyright © 2016 bepid. All rights reserved.
//

import Foundation
import GameKit

class GameCenter: UIViewController {
    
    
//    static var gcEnabled = Bool() // Stores if the user has Game Center enabled
//    
//    static var gcDefaultLeaderBoard = String() // Stores the default leaderboardID
    
    // Stores the score
//    static var score: Int{
//        get{
//            return self.score
//        }
//        set(newValue){
//            self.score = newValue
//        }
//    }
    
    
    
    class func authenticateLocalPlayer(view: ViewController){
        let localPlayer: GKLocalPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
            if((ViewController) != nil) {
                // 1 Show login if player is not logged in
                view.present(ViewController!, animated: true, completion: nil)
            } else if (localPlayer.isAuthenticated) {
//                // 2 Player is already euthenticated & logged in, load game center
//                GameCenter.gcEnabled = true
                
                // Get the default leaderboard ID
                localPlayer.loadDefaultLeaderboardIdentifier(completionHandler: {(leaderboardIdentifer: String?, error: Error?) -> Void in
                    if error != nil {
                        print(error)
                    } else {
//                        self.gcDefaultLeaderBoard = leaderboardIdentifer!
                    }
                })
                
                
            } else {
                // 3 Game center is not enabled on the users device
//                self.gcEnabled = false
//                print("Local player could not be authenticated, disabling game center")
                print(error)
            }
        }
        

    }
    
    class func submitScore(score: Int) {
        
        let leaderboardID = "Treino_classificacao" //Put here the ID what you put in itunes connect.
        let sScore = GKScore(leaderboardIdentifier: leaderboardID)
        sScore.value = Int64(score)
        
        
        GKScore.report([sScore], withCompletionHandler: {(error: Error?) -> Void in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Score submitted")
                self.updateAchivements(score: score)
                
            }
        })
        
        self.updateAchivements(score: score)
    }
    
    class func updateAchivements(score: Int) {
        
        var achivementsIndentifier: String = ""
        var progressPercentage = 0.0
        var progressInLevelAchievement = false
        
        var levelAchievement:GKAchievement? = nil
        var scoreAchievement:GKAchievement? = nil
        
        if(score >= 25){
            progressPercentage = Double(score * 100 / 25)
            achivementsIndentifier = "conquista_3"
            progressInLevelAchievement = true
        }
        if (score >= 40) {
            progressPercentage = Double(score * 100 / 40)
            achivementsIndentifier = "conquista"
            progressInLevelAchievement = true
        }
        
        if (progressInLevelAchievement) {
            levelAchievement = GKAchievement.init(identifier: achivementsIndentifier)
            
            levelAchievement?.percentComplete = progressPercentage
            
            print(progressPercentage)
        }
        
        scoreAchievement = GKAchievement.init(identifier: achivementsIndentifier)
        scoreAchievement?.percentComplete = progressPercentage
        
        let achivements: Array = progressInLevelAchievement ? [levelAchievement, scoreAchievement] : [scoreAchievement]
        
        GKAchievement.report(achivements as! [GKAchievement], withCompletionHandler: {(error: Error?) -> Void in
            if (error != nil){
                print(error!)
            }else{
                print("\n\n achivementsIndentifier: \(achivementsIndentifier) \n\n")
            }
        })
    }

    
    class func showLeaderboard(view: ViewController) {
        let gcVC: GKGameCenterViewController = GKGameCenterViewController()
        gcVC.gameCenterDelegate = view
        gcVC.viewState = GKGameCenterViewControllerState.leaderboards
        gcVC.leaderboardIdentifier = "Treino_classificacao"//Put here the ID what you put in itunes connect.
        view.present(gcVC, animated: true, completion: nil)
    }
    
    
    class func resetAchievements() {
        GKAchievement.resetAchievements { (error) in
            if(error != nil){
                print(error)
            }else{
                print("reset de achievements")
            }
        }
    }
    
    
    
    //Delegate
//    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
//        gameCenterViewController.dismiss(animated: true, completion: nil)
//    }

    
}
