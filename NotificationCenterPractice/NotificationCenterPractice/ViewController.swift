//
//  ViewController.swift
//  NotificationCenterPractice
//
//  Created by 권대윤 on 11/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: NSNotification.Name("TestNotification"), object: nil)
    }
    
    
    @objc func test(sender: Notification) {
        guard let str = sender.userInfo?["str"] as? String else {return}
        print(str)
    }
    


}

