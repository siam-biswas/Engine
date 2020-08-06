//
//  RootView.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Engine

protocol RootViewProtocol: View<RootViewModelProtocol> {
    
}

class RootView: View<RootViewModelProtocol>, RootViewProtocol{
    
    lazy var button = with(BaseButton()){
        $0.title = "Click"
        $0.titleColor = UIColor.black
        $0.setLayout(.autoLayout)
    }
    
    override func setupView() {
        super.setupView()
        addSubview(button)
    }
       
    override func setupLayout() {
        super.setupLayout()
        
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    override func setupViewModel() {
        super.setupViewModel()
    }
   
    override func setupReactive() {
        super.setupReactive()
        
        button.addTarget(selector, action: Selector{ [weak self] in
            self?.viewModel.action.value = .next
        }, for: .touchUpInside)
    }
}

