//
//  CustomView.swift
//  CustomViewCreatePractice
//
//  Created by 권대윤 on 11/30/23.
//

import UIKit

class CustomView: UIView {
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
        setup()
    }
    
    
    func customInit() {
        if let view = Bundle.main.loadNibNamed("CustomView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            addSubview(view)
        }
        
        
        
    }
    
    func setup() {
        myLabel.text = "test!!"
        backView.backgroundColor = .systemBlue
    }
    
    

}
