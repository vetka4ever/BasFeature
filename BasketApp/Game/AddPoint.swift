//
//  AddPoint.swift
//  BasketApp
//
//  Created by Даниил on 13.11.2020.
//

import Foundation
import UIKit
var addStage = 0
var addMinutes = 0
var addSeconds = 0

class AddPoint: UIViewController {
    override func viewDidLoad() {
        // MARK: CHANGE IMAGE
        let currentZone = zoneField
        addStage = fieldStage
        addMinutes = fieldMinutes
        addSeconds = fieldSecond
        basketField.image = UIImage(named:currentZone)
        sortTime(stage: addStageLabel, timer: addTimeLabel)
    }
    
    @IBOutlet var basketField: UIImageView!
    //-------
    // MARK: RETURN TO FIELD
    @IBAction func comeBack(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Field") as UIViewController
        nextViewController.modalPresentationStyle = .fullScreen
       self.present(nextViewController, animated: true, completion: nil)
        
    }
    //--------
    
    
    @IBOutlet var addStageLabel: UILabel!
    @IBOutlet var addTimeLabel: UILabel!
    var addTimer = Timer()
    
    
    
    
    
    
    
}



