//
//  InternetViewController.swift
//  VictorCodingChallenge_BottleRocket
//
//  Created by Victor Monteiro on 7/28/21.
//

import UIKit
import WebKit

class InternetViewController: UIViewController {
    
    // MARK: - Properties
    private let webView = WKWebView()
    private let navItem = UINavigationItem(title: "")
    private let navigationBar = UINavigationBar()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.setNavigationBar()
        self.setWebView()
    }
    
    // MARK: - UI Configuration Methods
    private func setView() {
        self.view.backgroundColor = UIColor(named: "customGreen")
    }
    
    private func setWebView() {
        
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: navigationBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        guard let url = URL(string: "https://www.bottlerocketstudios.com") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    private func setNavigationBar() {
        
        let backButtonItem = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(navigateBack))
        let forwardButtonItem = UIBarButtonItem(image: UIImage(named: "ic_webForward"), style: .plain, target: self, action: #selector(navigateForward))
        let reloadButtonItem = UIBarButtonItem(image: UIImage(named: "ic_webRefresh"), style: .plain, target: self, action: #selector(reloadWebView))
        
        navigationBar.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: 44)
        self.view.addSubview(navigationBar)
        
        self.navigationBar.tintColor = .white
        self.navigationBar.barTintColor = UIColor(named: "customGreen")
        navigationBar.isTranslucent = false
        
        navItem.setLeftBarButtonItems([backButtonItem, reloadButtonItem, forwardButtonItem], animated: false)
        navigationBar.items = [navItem]
    }
    
    // MARK: - WebView Action Methods
    @objc private func navigateBack() {
        self.webView.goBack()
    }
    
    @objc private func navigateForward() {
        self.webView.goForward()
    }
    
    @objc private func reloadWebView() {
        self.webView.reload()
    }
}
