//
//  MainViewController.swift
//  ECOM Messages
//
//  Created by Soroush on 1/18/24.

import UIKit

class MainViewController: UIViewController {
    
    let navBar = CustomNavBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        // setup navigation bar
        self.navBar.setUpCustomNavBar(view: self.view, navigationTitleText: "پیام های من")
    }
}
