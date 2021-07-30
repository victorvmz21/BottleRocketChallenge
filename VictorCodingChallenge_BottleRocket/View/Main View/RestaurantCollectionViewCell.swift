//
//  RestaurantCollectionViewCell.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var restaurantNameLabel: UILabel!
    @IBOutlet private var restaurantCategoryLabel: UILabel!
    
    // MARK: - Method Update Cell
    func updateCell(with restaurant: Restaurant) {
        DispatchQueue.main.async {
            self.backgroundImageView.getImageFromURL(imageURL: restaurant.backgroundImageURL)
            self.restaurantNameLabel.text = restaurant.name
            self.restaurantCategoryLabel.text = restaurant.category
        }
    }
    
}
