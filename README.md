# ENGINE

![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)
![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)
![CocoaPods](https://img.shields.io/cocoapods/v/Engine.svg) 
![Platform](https://img.shields.io/badge/platforms-iOS%208.0-F28D00.svg)

### Extended MVVM architecture framework in Swift


## What's ENGINE 

In present days when you start building any kind of data driven or large scale applications , the first thing you did is choose a decent architecture for your development. MVC, MVP, MVI, MVVM and VIPER are architecture patterns which are commonly used. Among those considering the ease of development and usabilty alongside with testabilty MVVM is the first choice for many of us. But when working with MVVM many of us faced diffuclties with maintaing consistency. As a solution ENGINE is here to make your development with MVVM more consistent, effecient and time saving.


E -> Entity -> Model 
N -> Navigation -> Coordinator
G -> Graphics -> View
I -> Interactor -> ViewModel
N -> Narrator -> Dependency 
E -> Events -> States & Actions


## Theory Of Engine

 <img src="MVVM.png" width="400"/>
 
In classic MVVM  we have Model, View & ViewModel. Now ViewModel is the place where we write all our UI indipendent logic based codes. But for a massive or complex feature a single ViewModel can get very messed up with different kinds of logic & dependency in one place. Also in classic MVVM the applications navigation flow is not managed.

<img src="MVVM+C.png" width="400"/>

As a solution first we are introducing the Coordinator for all our navigation and presentation releated tasks.

<img src="MVVM+CDE.png" width="400"/>

For offloading the ViewModel we are adding a Dependency element where we will put all our services (API/Storage etc) and outside dependent logics.

We are also adding some events for genralising our interaction and user experience flow.

<img src="Reactive.png" width="400"/>

Finally for the communication between different elements (Ex. View -> ViewModel / ViewModel -> View) , we are using the Reactive approach with data binding.

## Scaffolding

The Best thing about ENGINE is code templating tool or in one word Scaffolding. We have some predefine feature & view based template for your quick development process. All you have to do is download & run the "install-xcode-template" file and then from your project try adding a new file.


## Installation

### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `Engine` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
    pod 'Engine'
end
```

### Carthage 

You can use [Carthage](https://github.com/Carthage/Carthage) to install `Engine` by adding it to your `Cartfile`:

```
github "siam-biswas/Engine"
```

If you use Carthage to build your dependencies, make sure you have added `Engine.framework` to the "Linked Frameworks and Libraries" section of your target, and have included them in your Carthage framework copying build phase.

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Engine` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .package(url: "https://github.com/siam-biswas/Engine.git", from: "1.0.0"),
    ]
)
```

### Manually

To use this library in your project manually you may:  

1. for Projects, just drag all the (.swift) files from (Source\Engine) to the project tree
2. for Workspaces, include the whole Engine.xcodeproj

For installing ENGINE in your project we recommend the manual process by which you can get the full controll for customizing ENGINE elements based on your preferences.

## License

This project is licensed under the terms of the MIT license. See the LICENSE file for details.
