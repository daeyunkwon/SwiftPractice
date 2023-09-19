//
//  ViewController.swift
//  ClosureUseForDataSend
//
//  Created by 권대윤 on 2023/09/19.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet weak var firstTextView: UITextView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //텍스트뷰 빈내용으로 만들기
        firstTextView.text = nil
    }
    
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
        
        //두번째 뷰 컨트롤러에 있는 변수에 실행하고 싶은 클로저 저장하기
        secondVC.closureUseForDataSend = {[weak self] (sender) in
            //sender에는 두번째 뷰 컨트롤러에 있는 텍스트뷰의 문자열을 입력받으므로, 그대로 전달해주기
            self?.firstTextView.text = sender
        }
        
        present(secondVC, animated: true)
        
    }
    

}

