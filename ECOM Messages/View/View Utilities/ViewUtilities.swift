//
//  ViewUtilities.swift
//  ECOM Messages
//
//  Created by macbookpro13 on 1/21/24.
//

import UIKit

func calculateCellHeight(title: String, description: String, fullDescriptionCell: Bool) -> CGFloat {
    
    if fullDescriptionCell {
        let titleHeight = title.height(constraintedWidth: UIScreen.main.bounds.width, font: .systemFont(ofSize: 17))
        
        let descriptionHeight = description.height(constraintedWidth: UIScreen.main.bounds.width, font: .systemFont(ofSize: 17))
        
        return titleHeight + descriptionHeight + 320 // full description cell
    } else {
        return 227 // summary cell
    }
  
   
}
