//
//  RestaurantViewModel.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class RestaurantViewModel {
    
    // MARK: - Properties
    let dataService = DataServiceRestaurant()
    var restaurant: [Restaurant] = []
    var errorMessage: String = ""
    
    // MARK: - Fetch Method
    func fetchRestaurant(completion: @escaping (Error?) -> Void){
        dataService.fetchRestaurant { response in
            switch response {
            case .success(let restaurant):
                DispatchQueue.main.async {
                    self.restaurant = restaurant.restaurants
                    completion(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.errorMessage = "Could not fetch data, please try again."
                completion(error)
            }
        }
    }
}
