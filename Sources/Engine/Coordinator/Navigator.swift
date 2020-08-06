//
//  Navigator.swift
//  Engine
//
// Copyright (c) 2020 Siam Biswas.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import Foundation
import UIKit

/// Types adopting the `NavigatorProtocol` protocol can be used as Navigation & Presentation representer element for Coordinator
public protocol NavigatorProtocol {

    /// Executing the start task for specific coordinator based feature
    ///
    /// - Parameters:
    ///  - completion: A closure to call after starting related task is completed
    func start(completion: (()-> Void)?)
    
    /// Executing the end task for specific coordinator based feature
    ///
    /// - Parameters:
    ///  - completion: A closure to call after ending related task is completed
    func end(completion: (()-> Void)?)
}

// MARK: -

/// Used to represent the Navigation and Presentation type for Coordinator
///
/// - root:  presenting the feature as Root with assinging the base in the current `UIWindow`
///
/// - push: push the features base view controller in the navigation stack
///
/// - present: push the features base view controller
///
/// - container: add the features base view controller to a specific `UIView` as child container
///
/// - custom: custom presentation & navigation type.
public enum Navigator:NavigatorProtocol{
    
    case root(to:UIViewController?,from:UIWindow?,animation:Bool)
    case push(to:UIViewController?,from:UIViewController?,animation:Bool)
    case present(to:UIViewController?,from:UIViewController?,animation:Bool)
    case container(to:UIViewController?,from:UIViewController?,view:UIView?)
    case tab(to:UIViewController?,from:UITabBarController?,index:Int?)
    case custom(NavigatorProtocol)
    
    public func start(completion:(() -> Void)? = nil){
        switch self{
        case let .root(to,from,_):
            
            from?.makeKeyAndVisible()
            from?.rootViewController = nil
            from?.rootViewController = to
            completion?()
            
        case let .push(to,from,animation):
            defer {completion?()}
            guard let to = to else { return }
            from?.navigationController?.pushViewController(to, animated: animation)
        case let .present(to,from,animation):
            guard let to = to else {
                completion?()
                return
            }
            
            if let presented = from?.presentedViewController {
                presented.present(to, animated: animation, completion:  completion)
                return
            }
            
            from?.present(to, animated: animation, completion:  completion)
        case let .container(to,from,view):
            defer { completion?() }
            guard let to = to,let view = view else { return }
            from?.addChild(to)
            view.addSubview(to.view)
            to.view.frame = view.frame
            to.didMove(toParent: from)
        case let .tab(to,from,index):
            defer {completion?()}
            
            guard let to = to,let from = from else { return }
            
            if let index = index {
                to.navigationController?.popToRootViewController(animated: false)
                from.selectedIndex = index
            }else{
                from.viewControllers?.append(to)
            }
            
        case let .custom(value):
            value.start(completion: completion)
            
        }
    }
    
    public func end(completion: (()-> Void)? = nil){
        switch self{
        case let .root(_,from,_):
            from?.rootViewController = nil
            from?.makeKeyAndVisible()
            completion?()
        case let .push(to,_,animation):
            to?.navigationController?.popViewController(animated: animation)
            completion?()
        case let .present(to,_,animation):
            to?.dismiss(animated: animation, completion: completion)
        case let .container(to,_,_):
            to?.willMove(toParent: nil)
            to?.view.removeFromSuperview()
            to?.removeFromParent()
            completion?()
        case let .tab(to,_,_):
            to?.removeFromParent()
            completion?()
        case let .custom(value):
            value.end(completion: completion)
            
        }
    }
}



