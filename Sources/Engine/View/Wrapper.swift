//
// Wrapper.swift
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

// Types adopting the `WrapperBased` protocol can contain a custom `UIView` element
public protocol WrapperBased {
    
    /// Type for `UIView` element
    associatedtype View: UIView
    
    /// Returns the ``View` element``
    var wrapper: View { get }
}

// MARK: -

// Default implementation of `WrapperBased` for `UIViewController`
extension WrapperBased where Self: UIViewController {
    public var wrapper: View {
        guard let wrapper = view as? View else {
            fatalError("Expected view to be of type \(View.self) but got \(type(of: view)) instead")
        }
        return wrapper
    }
}
