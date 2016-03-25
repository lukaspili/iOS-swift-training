//
//  Element.swift
//  Training
//
//  Created by Lukasz on 24/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import Foundation

enum ElementType {
    case TypeOne
    case TypeTwo
}

struct Element {
    var name = ""
    var type = ElementType.TypeOne
    
    mutating func updateName(name: String) -> String {
        self.name = name
        
        return "tot"
    }
}