//
//  PNCoreDataHandler.swift
//  PNews
//
//  Created by Pramuka Dias on 10/6/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import CoreData

struct PNCoreDataHandler {
    
    static let viewContext: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    static func saveContext() -> Bool {
        do {
            try viewContext.save()
        } catch { return false }
        return true
    }
}

// MARK: Insertion

extension PNCoreDataHandler{
    
    static func saveUserDetails(userInfo: [String: String]) -> Bool {
        let user = NSEntityDescription.insertNewObject(forEntityName: "PNUser", into: viewContext) as? PNUser
        user?.fullname = userInfo["fullName"]
        user?.username = userInfo["userName"]
        user?.email = userInfo["email"]
        user?.password = userInfo["password"]
        return self.saveContext()
    }
}

// MARK: Fetching

extension PNCoreDataHandler{
    
    static func getUserDetails() -> PNUser {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PNUser")
            let result = try viewContext.fetch(request)
            let user = result as! [PNUser]
            return user.first!
        } catch {
            print("Could not fetch \(error.localizedDescription)")
            return PNUser()
        }
    }
    
}

// MARK: Updating

extension PNCoreDataHandler{
    
    static func updateUserDetails(user: PNUser, updatedUserInfo: [String: String]) -> Bool {
        user.fullname = updatedUserInfo["fullName"]
        user.username = updatedUserInfo["userName"]
        user.email = updatedUserInfo["email"]
        user.password = updatedUserInfo["password"]
        return self.saveContext()
    }
}
