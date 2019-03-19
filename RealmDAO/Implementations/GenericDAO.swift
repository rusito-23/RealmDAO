//
//  GenericDAO.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift

open class GenericDAO <T> : GenericDAOProtocol where T:Object, T:Transferrable {

  //  MARK: setup
  let background = { (block: @escaping () -> ()) in
    DispatchQueue.global(qos: .background).async (execute: block)
  }
  
  public init() { }

  //   MARK: protocol implementation
  
  public var realm: Realm? {
    get {
      return try? Realm()
    }
  }
  
  open func save(_ object: T, completion: @escaping (_ : Bool) -> () ) {
    background {
      do {
        let realm = try! Realm()
        try realm.write {
          realm.add(object)
        }
      } catch {
        completion(false)
      }
      completion(true)
    }
  }
  
  open func saveAutoincrement<T>(_ object: T, completion: @escaping (Bool) -> ()) where T:Object, T:Transferrable, T:Autoincrement {
    background {
      guard let `realm` = self.realm else {
        completion(false)
        return
      }
      
      do {
        let maxID = (realm.objects(T.self).max(ofProperty: "id") as Int? ?? 0) + 1
        object.setValue(maxID, forKey: "id")

        try realm.write {
          realm.add(object)
        }
      } catch {
        completion(false)
        return
      }
      
      completion(true)
    }
  }

  open func saveAll(_ objects: [T], completion: @escaping (_ : Int) -> () ){
    background {
      var count = 0
      guard let `realm` = self.realm else { completion(count); return }
      for obj in objects {
        do {
          try realm.write {
            // for every object added, increment counter
            realm.add(obj)
            count += 1
          }
        } catch {
        }
      }
      // send counter to completion
      completion(count)
    }
  }
  
  private func findAllResults() -> Results<T>? {
    return realm?.objects(T.self)
  }
  
  open func findAll(completion: @escaping ([T.S]) -> () ) {
    background {
      // parse the Realm Results into array
      guard let res = self.findAllResults() else { completion([]); return }
      completion(Array(res).map {$0.transfer()} )
    }
  }
  
  open func findByPrimaryKey(_ id: Any, completion: @escaping (T.S?) -> () ){
    background {
      completion(self.realm?.object(ofType: T.self, forPrimaryKey: id)?.transfer())
    }
  }
  
  open func updateByPrimaryKey(_ new: T, completion: @escaping (Bool) -> ()) {
    background {
      guard let key = T.primaryKey(), let pk = new.value(forKey: key) else {
        logger.error("Class \(T.className()) is not compliant for Primary Key searches")
        completion(true)
        return
      }
      
      // find old object by primary key
      do {
        guard var old = self.realm?.object(ofType: T.self, forPrimaryKey: pk) else {
          completion(true)
          return
        }
        
        // overwrite the old object with the new
        try self.realm?.write {
          old = new
        }
        completion(false)
        
      } catch {
        completion(true)
        return
      }

    }
  }
  
  open func deleteAll(completion: @escaping (_ : Bool) -> () ) {
    background {
      guard let res = self.findAllResults(),
        let `realm` = self.realm else {
          logger.error("No realm")
          completion(true)
          return
      }
      
      do {
        try realm.write {
          realm.delete(res)
          completion(false)
        }
      } catch {
        logger.error("error deleting movies")
        completion(true)
      }
    }
  }
  
  open func resolve(_ ref : ThreadSafeReference<T>) -> T? {
    let realm = try! Realm()
    return realm.resolve(ref)
  }
  
}

