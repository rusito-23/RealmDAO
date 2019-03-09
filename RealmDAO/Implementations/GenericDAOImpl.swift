//
//  GenericDAOImpl.swift
//  RealmDAO
//
//  Created by Igor on 09/03/2019.
//  Copyright © 2019 rusito23. All rights reserved.
//

import Foundation
import RealmSwift

public class GenericDAOImpl <T> : GenericDAO where T:Object, T:Structable {
  
  //  MARK: setup
  let background = { (block: @escaping () -> ()) in
    DispatchQueue.global(qos: .background).async (execute: block)
  }
  
  //   MARK: protocol implementation
  
  public func save(_ object: T, completion: @escaping (_ : Bool) -> () ) {
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
  
  public func saveAll(_ objects: [T], completion: @escaping (_ : Int) -> () ){
    background {
      var count = 0
      guard let realm = try? Realm() else { completion(count); return }
      for obj in objects {
        do {
          try realm.write {
            realm.add(obj)
            count += 1
          }
        } catch {
        }
      }
      completion(count)
    }
  }
  
  private func findAllResults() -> Results<T>? {
    if let realm = try? Realm() {
      return realm.objects(T.self)
    }
    return nil
  }
  
  public func findAll(completion: @escaping ([T.S]) -> () ) {
    background {
      guard let res = self.findAllResults() else { completion([]); return }
      completion(Array(res).map {$0.toStruct()} )
    }
  }
  
  public func findByPrimaryKey(_ id: Any, completion: @escaping (T.S?) -> () ){
    background{
      let realm = try? Realm()
      completion(realm?.object(ofType: T.self, forPrimaryKey: id)?.toStruct())
    }
  }
  
  public func deleteAll(completion: @escaping (_ : Bool) -> () ) {
    background {
      guard let res = self.findAllResults(),
        let realm = try? Realm() else {
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
  
  public func resolve(_ ref : ThreadSafeReference<T>) -> T? {
    let realm = try! Realm()
    return realm.resolve(ref)
  }
  
}

