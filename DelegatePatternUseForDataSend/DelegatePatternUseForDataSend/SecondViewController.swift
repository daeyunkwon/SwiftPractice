//
//  SecondViewController.swift
//  test
//
//  Created by 권대윤 on 2023/09/21.
//

import UIKit

protocol SecondViewDelegate: AnyObject {
    func update(text: String)
}

class SecondViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    weak var delegate: SecondViewDelegate?
    
    var temporaryString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI() {
        self.title = "두번째 화면"
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        button.setTitle("SAVE", for: .normal)
        
        textView.text = temporaryString
    }
    
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        //지정된 대리자가 있다면
        if self.delegate != nil {
            self.delegate?.update(text: textView.text)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
}
