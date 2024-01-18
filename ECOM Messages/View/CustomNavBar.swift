//
//  CustomNavBar.swift
//  ios new project
//
//  Created by Soroush

import UIKit

class CustomNavBar: UIView {
    
    static var customNavBar = CustomNavBar()
    
    let labelTitle = UILabel()
    var btnBack = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btnBack.addTarget(self, action:#selector(self.btnBackAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnBackAction() {
        print("btn back Clicked")
    }
    
    func setUpCustomNavBar(
        view: UIView,
        navigationTitleText: String,
        navigationBackgroundColor: UIColor = UIColor(red: 213/255.0, green: 246/255.0, blue: 254/255.0, alpha: 1.0),
        menuBtnHidden: Bool = false,
        backBtnHidden: Bool = true) {
            
            view.addSubview(self)
            self.addSubview(labelTitle)
            self.addSubview(btnBack)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = navigationBackgroundColor
            self.heightAnchor.constraint(equalToConstant: 60).isActive = true
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            
            labelTitle.translatesAutoresizingMaskIntoConstraints = false
            labelTitle.text = navigationTitleText
            labelTitle.textAlignment = .right
            labelTitle.textColor = .black
            labelTitle.font = labelTitle.font.withSize(24)
            labelTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
            labelTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            labelTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -52).isActive = true
            labelTitle.backgroundColor = UIColor(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 0.0)
            
            btnBack.translatesAutoresizingMaskIntoConstraints = false
            btnBack.setBackgroundImage(UIImage(named: "backicon"), for: .normal)
            btnBack.heightAnchor.constraint(equalToConstant: 22).isActive = true
            btnBack.widthAnchor.constraint(equalToConstant: 27).isActive = true
            btnBack.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
            btnBack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        }
}
