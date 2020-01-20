//
//  RealmService.swift
//  PNews
//
//  Created by Pramuka Dias on 1/20/20.
//  Copyright © 2020 Pramuka Dias. All rights reserved.
//

import Foundation
import RealmSwift

class RealmService {
    
    private init(){}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    func create<T: Object>(_ object: T) -> Bool{
        do{
            try realm.write {
                realm.add(object)
            }
            return true
        }catch{
            print(error)
            return false
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any]) -> Bool{
        do{
            try realm.write {
                for (key, value) in dictionary{
                    object.setValue(value, forKey: key)
                }
            }
            return true
        }catch{
            print(error)
            return false
        }
    }
    
}
