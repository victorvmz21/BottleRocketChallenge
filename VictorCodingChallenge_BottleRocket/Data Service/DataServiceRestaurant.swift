//
//  DataServiceRestaurant.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class DataServiceRestaurant: DataService {
    
    // MARK: - Fetch Restaurant Method
    func fetchRestaurant(completion: @escaping (Result<RestaurantData, Error>) -> Void) {
        
        var restaurantURL = URL(string: self.baseURL)
        restaurantURL?.appendPathComponent(self.restaurantsEndPoint)
        guard let url = restaurantURL else { return }
        
        print("✅ URL \(url)")
        
        let dataTask = URLSession(configuration: .ephemeral).dataTask(with: url) { data, _, error in
            
            if let error = error {
                print("Error fetching restaurants - \(error) \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
            if let data = data {
                
                let decoder = JSONDecoder()
                
                do {
                    let restaurantData = try decoder.decode(RestaurantData.self, from: data)
                    print(restaurantData)
                    DispatchQueue.main.async {
                        completion(.success(restaurantData))
                    }
                } catch let error {
                    print("Failed decoding Restaurant - \(error) \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            
        }
        
        dataTask.resume()
    }
}
