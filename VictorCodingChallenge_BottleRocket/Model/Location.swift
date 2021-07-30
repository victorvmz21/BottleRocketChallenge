//
//  Location.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class Location: Codable {
    
    // MARK: - Properties
    let lat: Double
    let long: Double
    let formattedAddress: [String]
    
    //MARK: - Implementation of CodingKey
    enum CodingKeys: String,CodingKey {
        case lat
        case long = "lng"
        case formattedAddress
    }
    
    // MARK: - Initializer
    init(lat: Double, long: Double, formattedAddress: [String]) {
        self.lat = lat
        self.long = long
        self.formattedAddress = formattedAddress
    }
}
