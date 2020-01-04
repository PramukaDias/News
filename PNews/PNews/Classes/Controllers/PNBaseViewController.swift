//
//  PNBaseViewController.swift
//  PNews
//
//  Created by Pramuka Dias on 10/5/19.
//  Copyright © 2019 Pramuka Dias. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class PNBaseViewController: UIViewController, NVActivityIndicatorViewable{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
    }
}

// MARK: Activity indicator

extension PNBaseViewController{
    
    func startActivityAnimating(message: String) {
        if self.isAnimating{
            stopActicityAnimating()
        }
        let size = CGSize(width: 30, height: 30)
        startAnimating(size, message: message, type: NVActivityIndicatorType.orbit)
    }
    
    func stopActicityAnimating() {
        self.stopAnimating()
    }
}

// MARK: Customize navigation bar

extension PNBaseViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = PNColors.APP_THEME_COLOR
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
    
}


