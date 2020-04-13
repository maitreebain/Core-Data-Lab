//
//  DisplayCell.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import ImageKit

protocol DisplayCellDelegate: AnyObject {
    func didPressFavoriteButton(_ cell: DisplayCell, _ image: Image)
}

class DisplayCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: DisplayCellDelegate?
    
    public var currentImageItem: Image!
    
    func configureCell(for image: Image) {
        currentImageItem = image
        imageView.getImage(with: image.largeImageURL) { [weak self] (result) in
            
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "xmark.circle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        delegate?.didPressFavoriteButton(self, currentImageItem)
        
    }
    
}
