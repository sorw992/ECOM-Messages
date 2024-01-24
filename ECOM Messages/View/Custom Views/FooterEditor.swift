//
//  FooterEditor.swift
//
//  Created by Soroush

import UIKit

protocol FooterEditorDelegate {
    func didTapDeleteButton()
    func didTapCancelButton()
}

class FooterEditor: UIView {
    
    static var customFooterEditor = FooterEditor()
    
    var delegate: FooterEditorDelegate?

    lazy var btndelete: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.baseBackgroundColor = UIColor(red: 254/255, green: 135/255, blue: 0/255, alpha: 1.0)
        button.configuration = config
        button.setTitle("حذف", for: .normal)
        return button
    }()
    
    lazy var btnCancel: UIButton = {
            let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.baseBackgroundColor = UIColor(red: 254/255, green: 135/255, blue: 0/255, alpha: 1.0)
        button.configuration = config
        button.setTitle("انصراف", for: .normal)
        return button
        }()
    
    lazy var horizontalStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [btndelete, btnCancel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
        stackView.distribution = .fillEqually
            stackView.spacing = 12
            return stackView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        btndelete.addTarget(self, action:#selector(self.btnDeleteAction), for: .touchUpInside)
        btnCancel.addTarget(self, action:#selector(self.btnCancelAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnDeleteAction() {
        print("btn delete Clicked")
        
        delegate?.didTapDeleteButton()
    }
    
    @objc func btnCancelAction() {
        print("btn cancel Clicked")
        
        delegate?.didTapCancelButton()
        
        self.removeFromSuperview()
    }
    
    func setupFooterEditor(
        view: UIView,
        navigationTitleText: String,
        navigationBackgroundColor: UIColor = UIColor(red: 213/255.0, green: 246/255.0, blue: 254/255.0, alpha: 1.0),
        menuBtnHidden: Bool = false,
        backBtnHidden: Bool = true) {
            
            view.addSubview(self)
            
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = navigationBackgroundColor
            self.heightAnchor.constraint(equalToConstant: 60).isActive = true
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
 
            self.addSubview(horizontalStackView)
            NSLayoutConstraint.activate([
                        horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
                        horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                        horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                        horizontalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        horizontalStackView.heightAnchor.constraint(equalToConstant: 50)
                    ])
        }
}
