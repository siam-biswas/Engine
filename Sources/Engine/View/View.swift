//
//  BaseView.swift
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

/// Types adopting the `ViewBased` protocol can  contain a `UIView` configurations
public protocol ViewBased{
    
    /// Returns a Bool value, indicates whether to setup view with default initialization
    var isSetup: Bool { get }
    
    /// Setup method for putting view configuration related code snippets
   func setupView()
}

/// Default implementation for `ViewBased`
public extension ViewBased{
   var isSetup: Bool { return true }
}


// MARK: -

/// Base class for `UIView`
open class BaseView: UIView, ViewBased, LayoutBased {
    
    open var isSetup: Bool { return true }

    required public init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    open func setup(){
        guard isSetup else { return }
        self.setupView()
        self.setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    open func setupView() { }
    open func setupLayout() { }
   
}

// MARK: -

/// Base class for `UIScrollView`
open class BaseScrollView: UIScrollView, ViewBased, LayoutBased{
    
    open var isSetup: Bool { return true }
    
    required public init() {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup(){
           guard isSetup else { return }
           self.setupView()
           self.setupLayout()
       }
       
    
    
    public func setupView() { }
    public func setupLayout() { }

}



// MARK: -

/// Base class for `UITableViewCell`
open class BaseTableViewCell: UITableViewCell, ViewBased, LayoutBased {
    
    open var isSetup: Bool { return true }
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    open func setup(){
        guard isSetup else { return }
        self.setupView()
        self.setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() { }
    open func setupLayout() { }
    
}

// MARK: -

/// Base class for `UICollectionViewCell`
open class BaseCollectionViewCell: UICollectionViewCell, ViewBased, LayoutBased{
    
     open var isSetup: Bool { return true }
    
    public init() {
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    open func setup(){
        guard isSetup else { return }
        self.setupView()
        self.setupLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setupView() { }
    open func setupLayout() { }
    
}

// MARK: -

/// Base class for `UIImageView`
open class BaseImageView: UIImageView, LayoutBased{
    
    convenience public init(){
        self.init(image: nil)
    }
    
    override public init(image: UIImage?) {
        super.init(image: image)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Set clound based image with following params
    ///
    /// - Parameters:
    ///  - url: A URL for set the image source
    ///  - placeholder: A UIImage for set as default image
    ///  - completion: A closure for getting the callback after image download and setup
    open func setImage(url:URL?, placeholder:UIImage? = nil, completion: ((UIImage?) -> Void)? = nil){
        
        guard let url = url else {
            image = placeholder
            completion?(image)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data,response,error in
            defer { completion?(self?.image )}
            guard let data = data else {
                self?.image = placeholder
                return
            }
            self?.image = UIImage(data: data)
        }).resume()
    }
}

// MARK: -

/// Base class for `UILabel`
open class BaseLabel: UILabel, LayoutBased{
    
    ///Type indicating the label with line configuration
    public enum LabelType{
        case singleline
        case multiline(Int)
    }
    
    /// Return the `LabelType`
    open var type:LabelType = .singleline{
        didSet{
            self.setType()
        }
    }
    
    public init(){
        super.init(frame: CGRect.zero)
        self.setType()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Setup the label configuration based on `LabelType`
    open func setType(){
        switch self.type {
        case .singleline:
            self.numberOfLines = 1
            self.lineBreakMode = .byTruncatingTail
        case .multiline(let value):
            self.numberOfLines = value
            self.lineBreakMode = .byWordWrapping
        }
    }
}

// MARK: -

/// Base class for `UIButton`
open class BaseButton: UIButton, LayoutBased{
    
    
    /// Property for get set the title value
    open var title:String?{
        get{ return self.title(for: .normal) }
        set{ self.setTitle(newValue, for: .normal)}
    }
    
    /// Property for get set the titleColor value
    open var titleColor:UIColor?{
        get{ return self.titleColor(for: .normal) }
        set{ self.setTitleColor(newValue, for: .normal)}
    }
    
    /// Property for get set the titleLabel's Font value
    open var titleFont:UIFont?{
        get{ return self.titleLabel?.font }
        set{ self.titleLabel?.font = newValue }
    }
    
    /// Property for get set the image value
    open var image:UIImage?{
        get{ return self.image(for: .normal) }
        set{ self.setImage(newValue, for: .normal)}
    }
    
    /// Property for get set the backgroundImage value
    open var backgroundImage:UIImage?{
        get{ return self.backgroundImage(for: .normal) }
        set{ self.setBackgroundImage(newValue, for: .normal)}
    }
    
    public init(){
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -

/// Base class for `UISwitch`
open class BaseSwitch: UISwitch, LayoutBased{
    
    public init(){
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -

/// Base class for `UITextField`
open class BaseTextField: UITextField, LayoutBased {

    
    public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: -

/// Base class for `UITextView`
open class BaseTextView: UITextView, LayoutBased{

    
    convenience public init(){
        self.init(frame: CGRect.zero, textContainer: nil)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -

/// Base class for `UITableView`
open class BaseTableView: UITableView, LayoutBased {
    
    public init(){
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
    }
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -

/// Base class for `UIPickerView`
open class BasePickerView: UIPickerView, LayoutBased{
    
    public init(){
        super.init(frame: CGRect.zero)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -

/// Base class for `UICollectionView`
open class BaseCollectionView: UICollectionView, LayoutBased{
    
    public init(){
        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    }
    
    public init(collectionViewLayout: UICollectionViewLayout){
        super.init(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
    }
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: -

/// Base class for `UIActivityIndicatorView`
open class BaseActivityIndicatorView: UIActivityIndicatorView, LayoutBased{
    
    
    required public init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override public init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: -

/// Base class for `UIVisualEffectView`
open class BaseVisualEffectView: UIVisualEffectView,LayoutBased {
    
    required public init() {
        super.init(effect: .none)
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

open class BaseSearchBar: UISearchBar {
    
    open override func layoutSubviews() {
        super.layoutSubviews()
    }
}

// MARK: -

/// Base class for `UIStackView`
@available(iOS 9.0, *)
class BaseStackView: UIStackView, LayoutBased {

    required public init() {
        super.init(frame: CGRect.zero)
    }
    
    required public init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
