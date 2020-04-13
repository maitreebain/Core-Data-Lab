//
//  CoreDataManager.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/13/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    private var users = [User]()
    
    private var favorites = [Favorites]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createUser(for name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        do {
            print("user created")
            try context.save()
        } catch {
            print("error saving user: \(error)")
        }
        
        return user
    }
    
    public func createFavorite(for user: User, imageURL: String, tags: String) -> Favorites {
        let favorite = Favorites(entity: Favorites.entity(), insertInto: context)
        favorite.imageURL = imageURL
        favorite.tags = tags
        
        do {
            try context.save()
            print("saved fav")
        } catch {
            print("error favoriting: \(error)")
        }
        
        return favorite
    }
    
    public func fetchFavorites() -> [Favorites]{
        do {
            favorites = try context.fetch(Favorites.fetchRequest())
            
        } catch {
            print("error fetching favs: \(error)")
        }
        return favorites
    }
    
    
}
