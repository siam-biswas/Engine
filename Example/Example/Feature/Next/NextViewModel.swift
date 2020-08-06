//
//  NextViewModel.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import Engine

protocol NextViewModelProtocol: ViewModel<NextCoordinatorProtocol,NextDependencyProtocol,NextAction,NextState> {
    
}

class NextViewModel: ViewModel<NextCoordinatorProtocol,NextDependencyProtocol,NextAction,NextState>, NextViewModelProtocol {
    
    override func initialize() {
        super.initialize()
    }
    
    override func setupReactive() {
        super.setupReactive()
    }
    
}
