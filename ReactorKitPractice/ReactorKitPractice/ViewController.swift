//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by 권대윤 on 10/24/24.
//

import UIKit

import ReactorKit
import RxSwift
import RxCocoa
import SnapKit

final class ViewController: UIViewController, View {
    
    var disposeBag = DisposeBag()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.text = "0"
        return label
    }()
    
    private let upButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("증가", for: .normal)
        return btn
    }()
    
    private let downButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("감소", for: .normal)
        return btn
    }()
    
    private let indicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
    }
    
    func bind(reactor: ViewReactor) {
        upButton.rx.tap
            .map { Reactor.Action.up }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        downButton.rx.tap
            .map { Reactor.Action.down }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.value }
            .distinctUntilChanged()
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isLoding }
            .distinctUntilChanged()
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        view.addSubview(countLabel)
        view.addSubview(upButton)
        view.addSubview(downButton)
        view.addSubview(indicatorView)
        
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        upButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview().offset(-50)
        }
        
        downButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview().offset(50)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(40)
        }
    }
}

