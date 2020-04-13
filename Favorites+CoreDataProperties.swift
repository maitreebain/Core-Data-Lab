//
//  Favorites+CoreDataProperties.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/13/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var likes: Int64
    @NSManaged public var tags: String?
    @NSManaged public var user: User?

}
