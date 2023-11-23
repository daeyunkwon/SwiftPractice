//
//  SecondViewController.swift
//  NotificationCenterPractice
//
//  Created by 권대윤 on 11/23/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("TestNotification"), object: nil, userInfo: ["str" : "Notification Post!!!"])
    }
    
    
    
    

}
