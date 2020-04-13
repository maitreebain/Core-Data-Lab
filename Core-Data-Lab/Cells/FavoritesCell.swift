//
//  FavoritesCell.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    
    public func configureCell(for favorite: Favorites) {
        
        guard let favImageURL = favorite.imageURL else { return }
        
        favImage.getImage(with: favImageURL) { [weak self] (result) in
            
            switch result{
            case .failure(let appError):
                print("no fav image found: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.favImage.image = image
                }
            }
        }
    }
}
