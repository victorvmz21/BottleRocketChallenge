//
//  Restaurant.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class RestaurantData: Codable {
    
    // MARK: - Properties
    let restaurants: [Restaurant]
    
    // MARK: Initializer
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
}

class Restaurant: Codable {
    
    // MARK: - Properties
    let name: String
    let backgroundImageURL: String
    let category: String
    let contact: Contact?
    let location: Location
    
    // MARK: - Initializer
    init(name: String, backgroundImageURL: String, category: String, contact: Contact, location: Location) {
        self.name = name
        self.backgroundImageURL = backgroundImageURL
        self.category = category
        self.contact = contact
        self.location = location
    }
}
