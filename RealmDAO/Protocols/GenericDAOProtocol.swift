//
//  GenericDAOProtocol.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift


public protocol GenericDAOProtocol {
  associatedtype T: Object, Transferrable
  associatedtype S = T.S
  
  var realm: Realm? { get }

  func save(_ object: T, completion: @escaping (_ : Bool) -> () )
  
  func saveAutoincrement<T>(_ object: T, completion: @escaping (Bool) -> ()) where T:Object, T:Transferrable, T:Autoincrement

  func saveAll(_ objects: [T], completion: @escaping (_ : Int) -> () )
  
  func findAll(completion: @escaping (_ : [S]) -> () )
  
  func findByPrimaryKey(_ id: Any, completion: @escaping (_ : S?) -> () )
  
  func updateByPrimaryKey(_ new: T, completion: @escaping (Bool) -> () )
  
  func deleteAll(completion: @escaping (_ : Bool) -> ())
  
  func resolve(_ ref : ThreadSafeReference<T>) -> T?
  
}

