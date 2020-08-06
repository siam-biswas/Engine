//
//  Coordinator.swift
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

import UIKit

/// Keys for storing the `Coordinator` protocol properties
fileprivate struct AssociatedKeys {
    static var identifier: UInt8 = 25
    static var base: UInt8 = 26
    static var navigator: UInt8 = 27
    static var parent: UInt8 = 28
}

// MARK: -

/// Types adopting the `CoordinatorBased` protocol can contain a `Coordinator` element
public protocol CoordinatorBased {
    
    /// Coordinator type
    associatedtype Coordinator
    
    /// Returns the `Coordinator` instance
    var coordinator: Coordinator { get set }
}

// MARK: -

/// Types adopting the `Coordinator` protocol can  be used as Coordinator components for Engine
public protocol Coordinator:class {
    
    /// Returns a unique identifier
    var identifier:String { get }
    
    /// Returns the `Base` element
    var base: Base? { get }
    
    /// Returns the `Navigator` element
    var navigator: Navigator? { get }
    
    /// Returns the `Coordinator` from which the current one is generated
    var parent: Coordinator? { get }
    
    /// Creates and start `Coordinator` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - coordinator:  a Coordinator object which will be added in the coordination flow
    ///   - completion:  a closure for setting the callback after new coordination flow completed
    /// - returns: The newly generated `Coordinator` instance.
    @discardableResult
    func next<T:Coordinator>(coordinator:T,completion: (()-> Void)?) -> T
    
    /// Start the current`Coordinator` instance
    ///
    /// - Parameters:
    ///   - completion:  a closure for setting the callback after star execution completed
    /// - returns: Self as `Coordinator` instance.
    @discardableResult
    func start(completion: (()-> Void)?) -> Self
    
    /// End the current `Coordinator` instance
    ///
    /// - Parameters:
    ///   - completion:  a closure for setting the callback after end execution completed
    /// - returns: Self as `Coordinator` instance.
    @discardableResult
    func end(completion: (()-> Void)?) -> Self
}


// MARK: -

/// Default implementations of `Coordinator` properties & methods
public extension Coordinator{
    
    var identifier:String {
        return String(describing: self)
    }

    var base: Base? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.base) as? Base
        }
        set(newValue) {
             objc_setAssociatedObject(self, &AssociatedKeys.base, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        
    var navigator: Navigator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navigator) as? Navigator
        }
        set(newValue) {
             objc_setAssociatedObject(self, &AssociatedKeys.navigator, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        
    var parent: Coordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.parent) as? Coordinator
        }
        set(newValue) {
             objc_setAssociatedObject(self, &AssociatedKeys.parent, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @discardableResult
    func next<T:Coordinator>(coordinator:T,completion: (()-> Void)?) -> T{
        coordinator.parent = self
        return coordinator.start(completion: completion)
    }
    
    @discardableResult
    func start(completion: (()-> Void)? = nil) -> Self{
        navigator?.start(completion: completion)
        return self
    }
    
    @discardableResult
    func end(completion: (()-> Void)? = nil) -> Self{
        navigator?.end(completion: completion)
        return self
    }

}




