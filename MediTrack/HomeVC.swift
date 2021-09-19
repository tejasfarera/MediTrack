//
//  ViewController.swift
//  MediTrack
//
//  Created by macmini45 on 19/09/21.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var wishingLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var medicineButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /// Currently just added the corner radius logic here as the button is only used once in project,
        /// if there mutliple used, then create a subclass of UIButton with customisations
        medicineButton.layer.cornerRadius = 15.0
    }


    @IBAction func onPressMedicineTaken(_ sender: UIButton) {
        
    }
}

