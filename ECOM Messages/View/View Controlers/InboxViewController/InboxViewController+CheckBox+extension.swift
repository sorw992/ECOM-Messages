//
//  Created by Soroush on 1/18/24.

import UIKit


extension InboxViewController: CheckBoxDelegate {
    
    // MARK: checkbox delegate
    func checkBoxTapped(messageItem: MessageItem, checked: Bool, index: Int) {
        
        if checked {
            // add to removedMessagesArray
            getMessageViewModel.removedMessagesArray.append(messageItem)
        } else {
            getMessageViewModel.uncheckSelectedElementForRemove(messageElement: messageItem)
        }
        
        getMessageViewModel.messagesData[index].checked = checked
        
        tableView.reloadData()
        
    }
    
    
}
