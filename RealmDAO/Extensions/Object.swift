//
//  Object.swift
//  RealmDAO
//
//  Created by Igor Andruskiewitsch on 19/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift

protocol PropertyReflectable { }

extension PropertyReflectable {
  subscript(key: String) -> Any? {
    let m = Mirror(reflecting: self)
    return m.children.first { $0.label == key }?.value
  }
  
  var keys: [String] {
    let m = Mirror(reflecting: self)
    return m.children.compactMap { $0.label }
  }
  
}

extension Object: PropertyReflectable { }
