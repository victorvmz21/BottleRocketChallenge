//
//  TabBarViewController.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/29/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarFont()
    }
    
    private func setTabBarFont() {
        guard let avenirFont = UIFont(name: "AvenirNext-Regular", size: 10) else { return }
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : avenirFont], for: .normal)
    }

}
