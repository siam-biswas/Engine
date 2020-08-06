//
//  NextController.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Engine

protocol NextControllerProtocol: ViewController<NextViewModelProtocol> {
    
}

class NextController: ViewController<NextViewModelProtocol>, NextControllerProtocol {
    
    override func setupController() {
        super.setupController()
    }
    
    override func setupView() {
        super.setupView()
    }
       
    override func setupLayout() {
        super.setupLayout()
    }
    
    override func setupViewModel() {
        super.setupViewModel()
    }
   
    override func setupReactive() {
        super.setupReactive()
    }
}

