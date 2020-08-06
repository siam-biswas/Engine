//
//  NextCoordinator.swift
//  Example
//
//  Created by Md. Siam Biswas on 27/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Engine

protocol NextCoordinatorProtocol: Coordinator{
    
}

class NextCoordinator: Coordinator, NextCoordinatorProtocol{
    
    init(from:UIViewController?) {
        
        let dependency = NextDependency()
        let viewModel = NextViewModel(coordinator: self, dependency: dependency)
        let controller = NextController.instantiate(viewModel)
        controller.title = "Next"
        
        base = .viewController(controller)
        navigator = .push(to: base?.viewController, from: from, animation: true)
    }
}

