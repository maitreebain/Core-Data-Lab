//
//  User+CoreDataProperties.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/13/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dob: String?
    @NSManaged public var name: String?
    @NSManaged public var favorites: Favorites?

}
