//
//  RootViewModel.swift
//  Example
//
//  Created by Md. Siam Biswas on 25/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import Engine

protocol RootViewModelProtocol: ViewModel<RootCoordinatorProtocol,RootDependencyProtocol,RootAction,RootState> {
   
}

class RootViewModel: ViewModel<RootCoordinatorProtocol,RootDependencyProtocol,RootAction,RootState>, RootViewModelProtocol {
    
    override func initialize() {
        super.initialize()
    }
    
    override func setupReactive() {
        super.setupReactive()
    }
    
}
