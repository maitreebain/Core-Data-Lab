//
//  FavoritesViewController.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var favoritesCollection: UICollectionView!
    
    private var favorites = [Favorites](){
        didSet{
            DispatchQueue.main.async {
                self.favoritesCollection.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesCollection.dataSource = self
        favoritesCollection.delegate = self
        loadFav()
    }
    
    private func loadFav() {
        favorites = CoreDataManager.shared.fetchFavorites()
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 10
        let maxWidth = UIScreen.main.bounds.size.width
        let numberOfItems: CGFloat = 3
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) ->  UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(favorites.count)
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not downcast to FavoriteCell")
        }
        let favorite = favorites[indexPath.row]
        
        cell.configureCell(for: favorite)
        
        return cell
    }
    
    
}

extension FavoritesViewController: DisplayDelegate {
    func createdFav(_ viewController: DisplayViewController, _ favItem: Favorites) {
        
        favorites.append(favItem)
    }
    
    
}
