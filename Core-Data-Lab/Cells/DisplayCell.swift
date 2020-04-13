//
//  DisplayCell.swift
//  Core-Data-Lab
//
//  Created by Maitree Bain on 4/12/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import ImageKit

class DisplayCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(for image: Image) {
        
        imageView.getImage(with: image.largeImageURL) { [weak self] (result) in
            
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "xmark.circle")
                }
            case .success(let image):
                self?.imageView.image = image
            }
        }
    }
}
