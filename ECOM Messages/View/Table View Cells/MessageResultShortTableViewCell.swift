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
    
    @IBOutlet weak var cellBackgroundRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelReadStatus: UILabel!
    
    
    @IBOutlet weak var btnShare: UIButton!
    
    @IBOutlet weak var labelMessageTitle: UILabel!
    
    @IBOutlet weak var labelMessageText: UILabel!
    
    @IBOutlet weak var imgArrowUpDownShowFullMessage: UIImageView!
    
    @IBOutlet weak var msgImage: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    
    
    // MARK: properties
    
    var messageItem: MessageItem?
    
    var saveMessageDelegate: SaveMessageDelegate?
    
    var checkboxDelegate: CheckBoxDelegate?
    
    var indexPath: IndexPath?
    
    // MARK: actions
    @IBAction func didTapBtnSave(_ sender: UIButton) {
        if let messageItem {
            saveMessageDelegate?.btnSaveTapped(messageItem: messageItem, index: (indexPath?.row)!)
        }
    }
    
    @IBAction func didTapBtnShare(_ sender: UIButton) {
        print("btn share action")
    }
    
    
    @IBAction func btnCheckBox(_ sender: UIButton) {
        if var messageItem {
            messageItem.checked = !messageItem.checked
            checkboxDelegate?.checkBoxTapped(messageItem: messageItem, checked: messageItem.checked, index: (indexPath?.row)!)
        }
    }
    
    
    // MARK: functions
    func configure(for messageItem: MessageItem, messageResultState: MessageResultState) {
        
        if messageResultState == .editMode {
            btnCheckBox.isHidden = false
            cellBackgroundRightConstraint.constant = 50
        } else {
            btnCheckBox.isHidden = true
            cellBackgroundRightConstraint.constant = 0
        }

        self.messageItem = messageItem
        
        backgroundColor = UIColor(red: 244/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
        
        viewBackground.layer.cornerRadius = 16
        
        selectionStyle = .none
        
        if messageItem.isSaved {
            btnSave.setImage(UIImage(named: "saveiconon"), for: .normal)
        } else {
            btnSave.setImage(UIImage(named: "saveicon"), for: .normal)
        }
        
        if messageItem.checked {
            btnCheckBox.setImage(UIImage(named: "checkboxFilled"), for: .normal)
        } else {
            btnCheckBox.setImage(UIImage(named: "checkboxEmpty"), for: .normal)
        }
        
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
        
        btnCheckBox.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
