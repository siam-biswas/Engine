//
//  Storyboard.swift
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

// Types adopting the `StoryboardBased` protocol can contain a `UIStoryboard` configuration
public protocol StoryboardBased {
    
    /// Returns a unique identifier
    static var identifier: String { get }
    
    /// Returns the associated `UIStoryboard`
    static var storyboard: UIStoryboard { get }
    
    /// Returns a `UIStoryboard` based on provided name
    ///
    /// - Parameters:
    ///   - name: a String value.
    /// - returns: The `UIStoryboard`
    static func getStoryboard(name:String) -> UIStoryboard
}

// MARK: -


/// Default implementations of `StoryboardBased` for `UIViewController`
public extension StoryboardBased where Self: UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
       
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
    
    static func getStoryboard(name:String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle(for: self))
    }
    
    /// Initialize a `UIViewController`` with conforming `StoryboardBased`
    ///
    /// - Parameters:
    ///   - name: a String value.
    /// - returns: The `UIViewController`
    static func instantiate() -> Self {
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("The VC of \\(sceneStoryboard) is not of class \\(self)")
        }
        return vc
    }
    
    /// Initialize a UIViewController with conforming `StoryboardBased` for a specific name
    ///
    /// - Parameters:
    ///   - name: a String value.
    /// - returns: The `UIViewController`
    static func instantiate(_ named:String) -> Self {
        guard let vc = getStoryboard(name: named).instantiateViewController(withIdentifier: Self.identifier) as? Self else {
            fatalError("The VC of \\(sceneStoryboard) is not of class \\(self)")
        }
        return vc
    }
}
