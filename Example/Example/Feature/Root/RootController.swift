//
//  RootController.swift
//  Example
//
//  Created by Md. Siam Biswas on 25/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Engine

protocol RootControllerProtocol: WrapperViewController<RootView> {
     func execute(_ value:RootAction)
     func navigateNext()
}

class RootController: WrapperViewController<RootView>, RootControllerProtocol {
    
    override func setupController() {
        super.setupController()
    }
    
    override func setupViewModel() {
        super.setupViewModel()
    }
   
    override func setupReactive() {
        super.setupReactive()
        
        viewModel.action.observe { [weak self] value in
            self?.execute(value)
        }.add(to: &disposal)
        
    }
    
    override func setupView() {
        super.setupView()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
}

    
extension RootController{
    
    func execute(_ value:RootAction){
        switch value{
        case .next:
            self.navigateNext()
        }
    }
    
    func navigateNext(){
        self.viewModel.coordinator.next(coordinator: NextCoordinator(from: self), completion: nil)
    }
}

