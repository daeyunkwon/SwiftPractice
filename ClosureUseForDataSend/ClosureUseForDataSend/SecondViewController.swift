//
//  SecondViewController.swift
//  ClosureUseForDataSend
//
//  Created by 권대윤 on 2023/09/19.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var secondTextView: UITextView!
    
    //함수 즉, 클로저를 담아둘 변수
    var closureUseForDataSend: ((_ text: String) -> Void) = {(sender) in}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //텍스트뷰 빈내용으로 만들기
        secondTextView.text = nil
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        //클로저가 담아져 있는 변수를 호출! -> 클로저를 실행한다.
        //TextView의 텍스트 내용을 전달
        closureUseForDataSend(self.secondTextView.text)
        
        //이전 화면으로 돌아가기
        dismiss(animated: true)
    }
    

}
