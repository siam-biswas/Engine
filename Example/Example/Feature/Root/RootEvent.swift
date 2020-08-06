//
//  RootEvent.swift
//  Example
//
//  Created by Md. Siam Biswas on 25/7/20.
//  Copyright © 2020 siambiswas. All rights reserved.
//

import Foundation
import Engine

enum RootState{
    case normal,empty,populated,loading,error
}

enum  RootAction{
    case next
}
