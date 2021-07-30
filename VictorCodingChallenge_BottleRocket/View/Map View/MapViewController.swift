//
//  MapViewController.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/29/21.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    var restaurants: [Restaurant]?
    var annotations: [MKAnnotation] = []
    
    // MARK: - IBOutlet
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet var dismissView: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.setMap()
    }
    
    // MARK: - UI Configuration
    func setMap() {
        
        if let restaurants =  restaurants {
            for restaurant in restaurants {
                guard let lat = CLLocationDegrees(exactly: restaurant.location.lat),
                      let long = CLLocationDegrees(exactly: restaurant.location.long) else { return }
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let annotation = MKPointAnnotation()
                annotation.title = restaurant.name
                annotation.coordinate = coordinate
                annotations.append(annotation)
            }
        }
        
        mapView.showAnnotations(annotations, animated: true)
        
    }
    
    func setView() {
        
        self.dismissView.layer.cornerRadius = self.dismissView.frame.height / 2
        self.dismissView.layer.masksToBounds = true
    }
    
}

// MARK: - MapView Delegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKMarkerAnnotationView()
        annotationView.titleVisibility = .visible
        annotationView.displayPriority = .required
        annotationView.canShowCallout = true
        annotationView.markerTintColor = UIColor(named: "customGreen")
        
        return annotationView
    }
    
}
