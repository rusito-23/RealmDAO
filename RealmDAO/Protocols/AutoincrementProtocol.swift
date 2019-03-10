//
//  AutoincrementProtocol.swift
//  RealmDAO
//
//  Created by Igor on 10/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift

public protocol Autoincrement {
  
  var id: RealmOptional<Int> { get set }
}
