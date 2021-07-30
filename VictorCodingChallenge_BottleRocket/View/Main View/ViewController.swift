//
//  ViewController.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/27/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = RestaurantViewModel()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var cellIdentifier = "restaurantCell"
    
    // MARK: - IBOutlet
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
        self.fetchRestaurant()
    }
    
    // MARK: - IBAction
    @IBAction func mapButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        guard let mapVC = storyboard.instantiateViewController(identifier: "mapVC") as? MapViewController else { return }
        mapVC.modalPresentationStyle = .pageSheet
        mapVC.restaurants = viewModel.restaurant
        self.present(mapVC, animated: true, completion: nil)
    }
    
    // MARK: - UI Configuration Methods
    private func setView() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.alpha = 0
        
        self.setNavigationBar()
        self.showSpinner()
    }
    
    private func setNavigationBar() {
        
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationController?.navigationBar.tintColor = .white
        let refreshBarButton: UIBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        self.navigationItem.leftBarButtonItem = refreshBarButton
    }
    
    // MARK: - Fetch Data Method
    private func fetchRestaurant() {
        
        self.viewModel.fetchRestaurant { error in
            if error != nil {
                DispatchQueue.main.async {
                    self.hideSpinner()
                    let alert = UIAlertController(title: "Error", message: self.viewModel.errorMessage, preferredStyle: .alert)
                    let retryButtonAction = UIAlertAction(title: "retry", style: .default) { _ in
                        self.showSpinner()
                        self.fetchRestaurant()
                    }
                    
                    alert.addAction(retryButtonAction)
                    self.present(alert, animated: true, completion: nil)
                }
                return
            } else {
                DispatchQueue.main.async {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    self.collectionView.reloadData()
                    self.hideSpinner()
                    self.animateCollectionView()
                }
            }
            
           
        }
    }
    
    // MARK: - Animation Methods
    private func showSpinner() {
        activityIndicator.startAnimating()
    }
    
    private func hideSpinner() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func animateCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        }
    }
    
}

// MARK: - ColletionView Data source && Delegate
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.restaurant.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,for: indexPath) as? RestaurantCollectionViewCell else { return UICollectionViewCell() }
        let restaurant = viewModel.restaurant[indexPath.row]
        cell.updateCell(with: restaurant )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let padding: CGFloat =  100
            let collectionViewSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
        }
        
        return CGSize(width: self.view.frame.width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return  UIEdgeInsets(top: 40, left: 40, bottom: 40, right: 40)
        }
        return  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 20
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 10
        }
        return 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let storyboard = UIStoryboard(name: "DetailView", bundle: nil)
        guard  let detailVC = storyboard.instantiateViewController(identifier: "detailVC") as? DetailViewController else { return }
        detailVC.restaurant = self.viewModel.restaurant[indexPath.row]
        detailVC.viewModel = self.viewModel
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
