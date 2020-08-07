//
//  RootModel.swift
//  Example
//
//  Created by Md. Siam Biswas on 25/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import Engine

protocol RootModelProtocol: Model {
    var title:String { get set}
    var action:String { get set }
}

struct RootModel: RootModelProtocol{
    var title:String
    var action:String
}

