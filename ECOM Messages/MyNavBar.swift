//
//  MyNavBar.swift
//  ios new project
//
//  Created by macbookpro on 5/4/20.
//  Copyright © 2020 com.app.iosnewproject. All rights reserved.
//

import Foundation



import Foundation
import UIKit




final class MyNavBar {
    
    static var myNavBar = MyNavBar()
    
    //declaring activity indicator
    let ActivityIndicatorBackground = UILabel()
    //let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let activityIndicator = UIActivityIndicatorView()
    let label = UILabel()
    //view1 for background with alpha for alert
    let view1 = UIView()
    
    
    
    
    
    func setUpMyNavBar(view: UIView, navigationTitleText: String, navigationBackgroundColor: UIColor = UIColor(red: 155/255.0, green: 120/255.0, blue: 100/255.0, alpha: 1.0), menuBtnHidden: Bool = false, backBtnHidden: Bool = true) {
        
        
        let navBackground = UILabel()
        let labelTitle = UILabel()
        let btnMenu = UIButton()

        
        view.addSubview(navBackground)
        
    
        
        navBackground.backgroundColor = navigationBackgroundColor
        navBackground.translatesAutoresizingMaskIntoConstraints = false
        navBackground.heightAnchor.constraint(equalToConstant: 60).isActive = true
        navBackground.widthAnchor.constraint(equalToConstant: 370).isActive = true
        navBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        navBackground.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        navBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
//        ToastBackground.layer.masksToBounds = true
//        ToastBackground.layer.cornerRadius = 4
        
        
        navBackground.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.text = navigationTitleText
        labelTitle.textAlignment = .center
        labelTitle.textColor = .black
       
        labelTitle.font = label.font.withSize(16)
        labelTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //labelTitle.widthAnchor.constraint(equalToConstant: 180).isActive = true
        labelTitle.topAnchor.constraint(equalTo: navBackground.topAnchor, constant: 8).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: navBackground.leftAnchor, constant: 6).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: navBackground.rightAnchor, constant: -6).isActive = true
        

        labelTitle.backgroundColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 0.0)
        
        
        
        ///////
        navBackground.addSubview(btnMenu)
        btnMenu.translatesAutoresizingMaskIntoConstraints = false
        btnMenu.setTitle("menu", for: .normal)
        
        
        btnMenu.backgroundColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        
        btnMenu.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //btnMenu.widthAnchor.constraint(equalToConstant: 180).isActive = true
        btnMenu.topAnchor.constraint(equalTo: navBackground.topAnchor, constant: 8).isActive = true
        
        btnMenu.rightAnchor.constraint(equalTo: navBackground.rightAnchor, constant: -6).isActive = true
        

        btnMenu.backgroundColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 0.0)
        
        
        
        
    }
    
    
    
    
    
    
    
    
}

