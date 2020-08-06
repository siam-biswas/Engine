//
// ViewModelBased.swift
// Engine
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

/// Types adopting the `ViewModelBased` protocol can be contain a `ViewModel` element
public protocol ViewModelBased {
    /// `ViewModel` type
    associatedtype ViewModel
    
    /// Returns the `ViewModel` element
    var viewModel: ViewModel! { get set }
    
    /// Setup method for putting ViewModel configuration related code snippets``
    func setupViewModel()
}

// MARK: -

/// Default implementations of `ViewModelBased` for `UIViewController`
public extension ViewModelBased where Self: UIViewController {
    
    private init() {
        self.init()
    }
    
    static func instantiate(_ viewModel: ViewModel) -> Self {
        var viewController = Self.init()
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func instantiate(_ viewModel:ViewModel, block: @escaping () -> Self ) -> Self {
        var viewController = block()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func setupViewModel() {}
}

// MARK: -

/// Default implementations of `ViewModelBased` for `UIView`
public extension ViewModelBased where Self: UIView {
    
    private init() {
        self.init()
    }
    
    static func instantiate(_ viewModel:ViewModel) -> Self {
        var view = Self.init()
        view.viewModel = viewModel
        return view
    }
    
    static func instantiate(_ viewModel:ViewModel, block: @escaping () -> Self ) -> Self {
        var view = block()
        view.viewModel = viewModel
        return view
    }
    
    func setupViewModel() { }
}

// MARK: -

/// Default implementations of `ViewModelBased` for `StoryboardBased` and `UIViewController`
public extension ViewModelBased where Self: StoryboardBased & UIViewController {
    
    private init() {
        self.init()
    }
    
    static func instantiate(_ viewModel:ViewModel) -> Self {
        var viewController = Self.instantiate()
        viewController.viewModel = viewModel
        return viewController
    }
    
    static func instantiate(_ storyboard:String, viewModel: ViewModel) -> Self {
        var viewController = Self.instantiate(storyboard)
        viewController.viewModel = viewModel
        return viewController
    }
}



