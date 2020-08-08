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
        
    }
    
    override func setupView() {
        super.setupView()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
}

    

