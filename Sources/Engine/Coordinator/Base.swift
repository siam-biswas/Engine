//
//  Base.swift
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

/// Types adopting the `BaseProtocol` protocol can be used as Base element for Coordinator
public protocol BaseProtocol {
    
    /// Returns the `UIWindow` associated with the current base
    var window:UIWindow? { get }
    
    /// Returns the `UINavigationController` associated with the current base
    var navigationController:UINavigationController? { get }
    
    /// Returns the `UIViewController` associated with the current base
    var viewController:UIViewController? { get }
    
    /// Returns the `UIView` associated with the current base
    var view:UIView? { get }
    
    /// Returns the `Custom` value  associated with the current base
    var value: Any { get }
}

// MARK: -

/// Used as  Base element for Coordinator
///
/// - window:  setup the base with UIWindow.
///
/// - viewController: setup the base with UIViewController.
///
/// - navigationController: setup the base with UINavigationController.
///
/// - view: setup the base with UIView.
///
/// - custom: setup the base with Any custom type of data.
public enum Base:BaseProtocol{
    
    case window(UIWindow)
    case viewController(UIViewController)
    case navigationController(UINavigationController)
    case view(UIView)
    case custom(Any)
    
    public var window:UIWindow?{
        switch self{
        case .window(let value):
            return value
        default : return nil
        }
    }
    
    public var navigationController:UINavigationController?{
        switch self{
        case .navigationController(let value):
            return value
        default : return nil
        }
    }
    
    public var viewController:UIViewController?{
        switch self{
        case .window:
            return window?.rootViewController
        case .navigationController:
            return navigationController?.viewControllers.first
        case .viewController(let value):
            return value
        default : return nil
        }
    }
    
    public var view:UIView?{
        switch self{
        case .window:
            return window?.rootViewController?.view
        case .navigationController:
            return navigationController?.viewControllers.first?.view
        case .viewController:
            return viewController?.view
        case .view(let value):
            return value
        default : return nil
        }
    }
    
    
    
    public var value:Any{
        switch self{
        case let .window(value):
            return value
        case let .viewController(value):
            return value
        case let .view(value):
            return value
        case let .navigationController(value):
            return value
        case let .custom(value):
            return value
        }
    }
}
