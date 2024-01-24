//
//  ViewUtilities.swift
//  ECOM Messages
//
//  Created by macbookpro13 on 1/21/24.
//

import UIKit

func calculateCellHeight(title: String, description: String, fullDescriptionCell: Bool) -> CGFloat {
    
    if fullDescriptionCell {
        let titleHeight = title.height(constraintedWidth: UIScreen.main.bounds.width, font: .systemFont(ofSize: 19))
        
        let descriptionHeight = description.height(constraintedWidth: UIScreen.main.bounds.width, font: .systemFont(ofSize: 18))
        
        return titleHeight + descriptionHeight + 320 // full description cell
    } else {
        return 227 // short cell
    }
  
   
}


func alertView(viewController: UIViewController, title: String = "", message: String = "", completion: @escaping () -> Void ) {
    
    // Create the alert controller
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) {
        UIAlertAction in
        
        completion()
        
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)

    
    viewController.present(alertController, animated: true, completion: nil)
    
}
