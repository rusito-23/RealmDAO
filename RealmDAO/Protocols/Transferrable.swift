//
//  Transferrable.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation


public protocol Transferrable {
  associatedtype S
  func transfer() -> S
}
