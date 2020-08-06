//___FILEHEADER___

import Foundation
import UIKit
import Engine

protocol ___FILEBASENAMEASIDENTIFIER___Protocol: Coordinator{
    
}

class ___FILEBASENAMEASIDENTIFIER___: Coordinator, ___FILEBASENAMEASIDENTIFIER___Protocol{
    
    init(window:UIWindow?) {
        
        let dependency = ___VARIABLE_productName___Dependency()
        let viewModel = ___VARIABLE_productName___ViewModel(coordinator: self, dependency: dependency)
        let controller = ___VARIABLE_productName___Controller.instantiate(viewModel)
        
        base = .navigationController(BaseNavigationController(rootViewController: controller))
        navigator = .root(to: base?.navigationController, from: window, animation: true)
    }
}

