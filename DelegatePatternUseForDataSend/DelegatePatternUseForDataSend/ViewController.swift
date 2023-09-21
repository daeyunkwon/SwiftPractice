//
//  ViewController.swift
//  test
//
//  Created by 권대윤 on 2023/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI() {
        self.title = "첫번째 화면"
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        textView.text = nil
        button.setTitle("내용 수정하기", for: .normal)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSecondViewSegue" {
            guard let secondVC = segue.destination as? SecondViewController else {return}
            
            //대리자 지정하기
            secondVC.delegate = self
            //현재 텍스트뷰의 문자열 넘겨주기
            secondVC.temporaryString = self.textView.text
            
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ToSecondViewSegue", sender: nil)
    }
    
}

extension ViewController: SecondViewDelegate {
    func update(text: String) {
        print(#function)
        self.textView.text = text
    }
    
    
}

