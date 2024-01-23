//
//  MessageResultTableViewCell.swift
//  ECOM Messages
//
//  Created by macbookpro13 on 1/21/24.
//

import UIKit

class MessageResultShortTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var viewBackground: UIView!
    
    @IBOutlet weak var labelReadStatus: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var labelMessageTitle: UILabel!
    
    @IBOutlet weak var labelMessageText: UILabel!
    
    @IBOutlet weak var imgArrowUpDownShowFullMessage: UIImageView!
    
    @IBOutlet weak var msgImage: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    // MARK: properties
    
    var messageItem: MessageItem?
    
    // MARK: actions
    @IBAction func didTapBtnSave(_ sender: UIButton) {
        if let messageItem {
            SQLiteCommands.insertRow(messageItem)
        }
    }
    
    @IBAction func didTapBtnShare(_ sender: UIButton) {
        print("btn share action")
    }
    
    // MARK: functions
    func configure(for messageItem: MessageItem) {

        
        self.messageItem = messageItem
        
        backgroundColor = UIColor(red: 244/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
        
        viewBackground.layer.cornerRadius = 16
        
        selectionStyle = .none
        
        if messageItem.unread == true {
            self.viewBackground?.backgroundColor = .white
            labelReadStatus.text = "خوانده نشده"
        } else {
            self.viewBackground?.backgroundColor = UIColor(red: 239/255.0, green: 243/255.0, blue: 246/255.0, alpha: 1.0)
            labelReadStatus.text = "خوانده شده"
        }
        
        if messageItem.fullText == true {
            imgArrowUpDownShowFullMessage.image = UIImage(named: "arrowupicon")
        } else {
            imgArrowUpDownShowFullMessage.image = UIImage(named: "arrowdownicon")
        }
        
        
        labelMessageTitle.text = messageItem.title
        labelMessageText.text = messageItem.description
        
        if let imageURL = messageItem.imageUrl {
            msgImage.load(url: URL(string: imageURL)!)
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
