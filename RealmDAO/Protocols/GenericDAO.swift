//
//  GenericDAO.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift


protocol Structable {
  associatedtype S
  func toStruct() -> S
}

protocol GenericDAO {
  associatedtype T: Object, Structable
  associatedtype S = T.S
  
  func save(_ object: T, completion: @escaping (_ : Bool) -> () )
  
  func saveAll(_ objects: [T], completion: @escaping (_ : Int) -> () )
  
  func findAll(completion: @escaping (_ : [S]) -> () )
  
  func findByPrimaryKey(_ id: Any, completion: @escaping (_ : S?) -> () )
  
  func deleteAll(completion: @escaping (_ : Bool) -> ())
  
  func resolve(_ ref : ThreadSafeReference<T>) -> T?
  
}

