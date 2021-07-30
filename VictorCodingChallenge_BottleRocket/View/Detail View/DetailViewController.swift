//
//  DetailViewController.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/28/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    // MARK: - Properties
    var restaurant: Restaurant?
    var viewModel: RestaurantViewModel?
    
    // MARK: - IBOutlet
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var restaurantNameLabel: UILabel!
    @IBOutlet private var restaurantCategoryLabel: UILabel!
    @IBOutlet private var restaurantAddressLabel: UILabel!
    @IBOutlet private var restaurantPhoneNumberLabel: UILabel!
    @IBOutlet private var restaurantTwitterLabel: UILabel!

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.setNavigationBar()
    }
    
    // MARK: - UI Configuration Methods
    private func setView() {
        
        if let restaurant = restaurant {
            self.restaurantNameLabel.text = restaurant.name
            self.restaurantCategoryLabel.text = restaurant.category
            self.restaurantAddressLabel.text = "\(String(describing: restaurant.location.formattedAddress[0])) \n \(String(describing: restaurant.location.formattedAddress[1]))"
            self.restaurantPhoneNumberLabel.text = restaurant.contact?.formattedPhone ?? "Phone not available"
            if let twitter = restaurant.contact?.twitter {
                self.restaurantTwitterLabel.text = "@\(twitter)"
            } else {
                self.restaurantTwitterLabel.text = "twitter not availabel"
            }
            
            self.setMapView(restaurant: restaurant)
        }
    }
    
    private func setNavigationBar() {
        
        self.title = "Lunch Tyme"
        self.navigationController?.navigationBar.tintColor = .white
        let mapButtonItem = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .plain, target: self, action: #selector(navigationBarButtonTapped))
        navigationItem.rightBarButtonItem = mapButtonItem
    }
    
    private func setMapView(restaurant: Restaurant) {
        
        guard let lat  = CLLocationDegrees(exactly: restaurant.location.lat),
              let long = CLLocationDegrees(exactly: restaurant.location.long) else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.title = restaurant.name
        mapAnnotation.coordinate = coordinate
        
        self.mapView.setRegion(MKCoordinateRegion(center: coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000), animated: false)
        self.mapView.showAnnotations([mapAnnotation], animated: true)
    }

    @objc private func navigationBarButtonTapped() {
        
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(identifier: "mapVC") as? MapViewController else { return }
        mapVC.modalPresentationStyle = .pageSheet
        mapVC.restaurants = self.viewModel?.restaurant ?? [Restaurant]()
        self.present(mapVC, animated: true, completion: nil)
    }
}
