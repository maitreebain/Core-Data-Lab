//
//  ViewController.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var images = [Image](){
        didSet{
            DispatchQueue.main.async {
                self.searchCollectionView.reloadData()
            }
        }
    }
    
    private var users = [User]()
    
    private var selectedUser: User?
    
    private var searchQuery = "" {
        didSet{
            loadData(for: searchQuery)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searchBar.delegate = self
        selectedUser = users.first
        
    }
    
    private func loadData(for search: String) {
        ImageAPIClient.fetchImages(for: searchQuery) { (result) in
            
            switch result{
            case .failure(let appError):
                print("no results: \(appError)")
            case .success(let images):
                self.images = images
            }
        }
    }
    

}

extension DisplayViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "displayCell", for: indexPath) as? DisplayCell else {
            fatalError("could not")
        }
        
        let image = images[indexPath.row]
        
        cell.configureCell(for: image)
        cell.delegate = self
        
        return cell
    }
    
}

extension DisplayViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchText = searchBar.text else { return }
        searchBar.resignFirstResponder()
        loadData(for: searchText)
        searchQuery = searchText
    }

}

extension DisplayViewController: DisplayCellDelegate {
    func didPressFavoriteButton(_ cell: DisplayCell, _ image: Image) {
        
        guard let user = selectedUser,
            let tags = image.tags else { return }
        
        CoreDataManager.shared.createFavorite(for: user, imageURL: image.largeImageURL, tags: tags)
        
    }
    
    
}
