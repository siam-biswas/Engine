//
//  ControllerBased.swift
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

// Keys for storing the ControllerBased` protocol properties
fileprivate struct AssociatedKeys {
    static var controller: UInt8 = 60
}

/// Used to represent the View Controller Lifecycle
public enum Controller{
    case didLoad, willAppear, didAppear, willDisappear, didDisappear, `deinit`, didMove, willMove, memoryWarning, willTransition, didLayout, willLayout, viewWillTransition
}

// MARK: -

/// Types adopting the `ControllerBased` protocol can  contain a `Controller` lifecycle observable element
public protocol ControllerBased:class {
    
     /// Returns the Application as Observable
    var controller: Observable<Controller> { get set }
    
    /// Setup method for putting controller configuration related code snippets
    func setupController()
    
    /// Method for putting commong code snippets for all type of Controller
    func initialize()
    
}

// MARK: -

/// Default implementations of `ControllerBased`
extension ControllerBased {

    public var controller: Observable<Controller> {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.controller) as? Observable<Controller> else {
                let newValue = Observable<Controller>()
                objc_setAssociatedObject(self, &AssociatedKeys.controller, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return newValue
            }
            return value
        }
        set(newValue) {
             objc_setAssociatedObject(self, &AssociatedKeys.controller, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: -

/// Default implementations of `ControllerBased`for `UIViewController`
extension ControllerBased where Self: UIViewController {
    
    public func initialize() {
        
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.view.backgroundColor = UIColor.white
        self.view.backgroundColor = UIColor.white
        
    }

}


// MARK: -

/// Base class for `UIViewController`
open class BaseViewController: UIViewController, ControllerBased, ViewBased, LayoutBased {

    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open func setupController() { }
    open func setupView() { }
    open func setupLayout() { }
       
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.setupController()
        self.setupView()
        self.setupLayout()
        self.controller.value = .didLoad
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controller.value = .willDisappear
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controller.value = .didDisappear
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controller.value = .didLayout
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.controller.value = .willLayout
    }
    
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.controller.value = .didMove
    }
    
    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.controller.value = .willMove
    }
    
    override open func viewWillTransition(to size: CGSize, with navigator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: navigator)
        self.controller.value = .viewWillTransition
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with navigator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: navigator)
        self.controller.value = .willTransition
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.controller.value = .memoryWarning
    }
    
    
    deinit {
        self.controller.value = .deinit
    }
}

// MARK: -


/// Base class for `UITableViewController`
open class BaseTableViewController: UITableViewController, ControllerBased, ViewBased, LayoutBased {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open func setupController() { }
    open func setupView() { }
    open func setupLayout() { }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.setupController()
        self.setupView()
        self.setupLayout()
        self.controller.value = .didLoad
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controller.value = .didAppear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controller.value = .willDisappear
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controller.value = .didDisappear
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controller.value = .didLayout
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.controller.value = .willLayout
    }
    
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.controller.value = .didMove
    }
    
    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.controller.value = .willMove
    }
    
    override open func viewWillTransition(to size: CGSize, with navigator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: navigator)
        self.controller.value = .viewWillTransition
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with navigator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: navigator)
        self.controller.value = .willTransition
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.controller.value = .memoryWarning
    }
    
    
    deinit {
        self.controller.value = .deinit
    }
}

// MARK: -


/// Base class for `UICollectionViewController`
open class BaseCollectionViewController: UICollectionViewController, ControllerBased, ViewBased, LayoutBased {
    
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open func setupController() { }
    open func setupView() { }
    open func setupLayout() { }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.setupController()
        self.setupView()
        self.setupLayout()
        self.controller.value = .didLoad
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controller.value = .didAppear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controller.value = .willDisappear
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controller.value = .didDisappear
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controller.value = .didLayout
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.controller.value = .willLayout
    }
    
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.controller.value = .didMove
    }
    
    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.controller.value = .willMove
    }
    
    override open func viewWillTransition(to size: CGSize, with navigator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: navigator)
        self.controller.value = .viewWillTransition
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with navigator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: navigator)
        self.controller.value = .willTransition
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.controller.value = .memoryWarning
    }
    
    
    deinit {
        self.controller.value = .deinit
    }
    
}


// MARK: -

/// Base class for `UITabBarController`
open class BaseTabBarController: UITabBarController, ControllerBased, ViewBased, LayoutBased {
    
    public enum TabEvent{
        case didSelect(UITabBarItem),didBeginCustomizing,willBeginCustomizing,didEndCustomizing,willEndCustomizing
    }

    open var tab:Observable<TabEvent> = Observable()
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open func setupController() { }
    open func setupView() { }
    open func setupLayout() { }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
        self.setupController()
        self.setupView()
        self.setupLayout()
        self.controller.value = .didLoad
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controller.value = .didAppear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controller.value = .willDisappear
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controller.value = .didDisappear
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controller.value = .didLayout
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.controller.value = .willLayout
    }
    
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.controller.value = .didMove
    }
    
    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.controller.value = .willMove
    }
    
    override open func viewWillTransition(to size: CGSize, with navigator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: navigator)
        self.controller.value = .viewWillTransition
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with navigator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: navigator)
        self.controller.value = .willTransition
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.controller.value = .memoryWarning
    }
    
    
    deinit {
        self.controller.value = .deinit
    }
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.tab.value = .didSelect(item)
    }
    
    open override func tabBar(_ tabBar: UITabBar, didBeginCustomizing items: [UITabBarItem]) {
        self.tab.value = .didBeginCustomizing
    }
    
    open override func tabBar(_ tabBar: UITabBar, willBeginCustomizing items: [UITabBarItem]) {
        self.tab.value = .willBeginCustomizing
    }
    
    open override func tabBar(_ tabBar: UITabBar, didEndCustomizing items: [UITabBarItem], changed: Bool) {
        self.tab.value = .didEndCustomizing
    }
    
    open override func tabBar(_ tabBar: UITabBar, willEndCustomizing items: [UITabBarItem], changed: Bool) {
        self.tab.value = .willEndCustomizing
    }
}


// MARK: -


/// Base class for `UINavigationController`
open class BaseNavigationController: UINavigationController, ControllerBased, ViewBased, LayoutBased {
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    open func setupController() { }
    open func setupView() { }
    open func setupLayout() { }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.setupController()
        self.setupView()
        self.setupLayout()
        self.controller.value = .didLoad
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.controller.value = .willAppear
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.controller.value = .didAppear
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.controller.value = .willDisappear
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.controller.value = .didDisappear
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.controller.value = .didLayout
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.controller.value = .willLayout
    }
    
    
    override open func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.controller.value = .didMove
    }
    
    override open func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        self.controller.value = .willMove
    }
    
    override open func viewWillTransition(to size: CGSize, with navigator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: navigator)
        self.controller.value = .viewWillTransition
    }
    
    override open func willTransition(to newCollection: UITraitCollection, with navigator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: navigator)
        self.controller.value = .willTransition
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.controller.value = .memoryWarning
    }
    
    
    deinit {
        self.controller.value = .deinit
    }
    
}

// MARK: -

/// Base class for `UISearchController`
open class BaseSearchController: UISearchController {
    
    
    open var backgroundColor:UIColor?{
        didSet{
            searchBar.backgroundColor = backgroundColor
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.backgroundColor = backgroundColor
            }else{
                guard let searchTextField =  self.searchBar.value(forKey: "searchField") as? UITextField else { return }
                searchTextField.backgroundColor = backgroundColor
            }
        }
    }
    
    open var placeholder:String?{
        didSet{
            if #available(iOS 13.0, *) {
                searchBar.searchTextField.placeholder = placeholder
            }else{
                guard let searchTextField =  self.searchBar.value(forKey: "searchField") as? UITextField else { return }
                guard searchTextField.responds(to: #selector(getter: UITextField.attributedPlaceholder)) else { return }
                searchTextField.placeholder = placeholder
            }
        
        }
    }
    
    
}
