//
// Application.swift
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

/// Keys for storing the ApplicationBased` protocol properties
fileprivate struct AssociatedKeys {
    static var application: UInt8 = 70
}

// MARK: -

/// Used to represent the Application Lifecycle
///
/// - willEnterForground: Called before app gets active
///
/// - didBecomeActive: Called after app became active
///
/// - willResignActive: Called before app going to background
///
/// - didEnterBackground: Called after app goes to background
///
/// - willTerminate: Called before app get terminated
///
/// - contentSizeChange: Called after text size changed from system settings

public enum Application{
    case willEnterForground, didBecomeActive, willResignActive, didEnterBackground, willTerminate, contentSizeChange
}

// MARK: -

/// Types adopting the `ApplicationBased` protocol can  contain a `Application` lifecycle observable element
public protocol ApplicationBased:class {
    
    /// Returns the Application as Observable
    var application : Observable<Application> { get set }
    
    
    /// Setup NotificationCenter Observer for different application lifecycle states
    func setupApplicationObserver()
}

// MARK: -

/// Default implementation for `ApplicationBased`
public extension ApplicationBased {

    var application: Observable<Application> {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.application) as? Observable<Application> else {
                let newValue = Observable<Application>()
                objc_setAssociatedObject(self, &AssociatedKeys.application, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newValue
            }
            return value
        }
        set(newValue) {
             objc_setAssociatedObject(self, &AssociatedKeys.application, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    
    func setupApplicationObserver() {
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .willEnterForground
        }, name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .didBecomeActive
        }, name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .willResignActive
        }, name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
           self?.application.value = .didEnterBackground
        }, name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .willTerminate
        }, name: UIApplication.willTerminateNotification, object: nil)
       
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .willTerminate
        }, name: UIContentSizeCategory.didChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(selector, selector: Selector{ [weak self] in
            self?.application.value = .contentSizeChange
        }, name: UIContentSizeCategory.didChangeNotification, object: nil)

    }
    
}

