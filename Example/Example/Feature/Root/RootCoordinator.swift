//
//  RootCoordinator.swift
//  Example
//
//  Created by Md. Siam Biswas on 25/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import UIKit
import Engine

protocol RootCoordinatorProtocol: Coordinator{
    func navigateNext()
}

class RootCoordinator: Coordinator, RootCoordinatorProtocol{
    
    init(window:UIWindow?) {
        
        let dependency = RootDependency()
        let viewModel = RootViewModel(coordinator: self, dependency: dependency)
        let controller = RootController.instantiate(viewModel)
        controller.title = "Root"
        
        base = .navigationController(BaseNavigationController(rootViewController: controller))
        navigator = .root(to: base?.navigationController, from: window, animation: true)
    }
    
    func navigateNext(){
        guard let from = self.base?.viewController else { return }
        self.next(coordinator: NextCoordinator(from: from), completion: nil)
    }
}

