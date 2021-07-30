//
//  Contact.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class Contact: Codable {
    
    // MARK: - Properties
    let formattedPhone: String?
    let twitter: String?
    
    // MARK: - Initializer
    init(formattedPhone: String, twitter: String) {
        self.formattedPhone = formattedPhone
        self.twitter = twitter
    }
}

