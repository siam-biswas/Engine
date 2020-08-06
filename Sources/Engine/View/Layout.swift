//
//  Layout.swift
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

/// Used to represent the view layputing types
///
/// - autoResize:  layout with auto resizing mask
///
/// - autoLayout:  layout with auto layout constraints
public enum Layout {
    case autoResize, autoLayout
}

// MARK: -

/// Types adopting the `LayoutBased` protocol can be contain a `Layout` configuration element
public protocol LayoutBased {
    
    /// Returns the `Layout`
    var layout: Layout { get set }
    
    /// Set the `Layout`
    ///
    /// - Parameters:
    ///  - type: A Layout configuration element
    func setLayout(_ type:Layout)
    
    /// Setup method for putting view layout related code snippets``
    func setupLayout()
}

// MARK: -

/// Default implementations of `LayoutBased` for `UIView`
public extension LayoutBased where Self: UIView {
    
    
    var layout: Layout {
        get { return self.translatesAutoresizingMaskIntoConstraints == false ? .autoLayout : .autoResize }
        set { self.translatesAutoresizingMaskIntoConstraints = newValue == .autoLayout ? false : true }
    }
    
    func setLayout(_ type:Layout) {
        self.translatesAutoresizingMaskIntoConstraints = type == .autoLayout ? false : true
    }
    
    func setupLayout() { }
}

// MARK: -

///Default implemebtations of `LayoutBased` for `UIViewController`
public extension LayoutBased where Self: UIViewController {
    
    
    var layout: Layout {
        get { return self.view.translatesAutoresizingMaskIntoConstraints == false ? .autoLayout : .autoResize }
        set { self.view.translatesAutoresizingMaskIntoConstraints = newValue == .autoLayout ? false : true }
    }
    
    func setLayout(_ type:Layout) {
        self.view.translatesAutoresizingMaskIntoConstraints = type == .autoLayout ? false : true
    }
    
    
    func setupLayout() { }
}
