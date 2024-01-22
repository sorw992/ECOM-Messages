//
//  Created by Soroush on 1/19/24.

import Foundation

class GetMessageViewModel {
    
    var messagesData = [MessageItem]()
    
    func fetchData(updateUI: @escaping ([MessageItem]?, String?) -> Void) {
        
        NetworkManager.shared.getApiMessages { messages, error in
            
            if let error {
                DispatchQueue.main.async {
                    updateUI(nil, error.localizedDescription)
                }
            }
            
            if let messages {
                
                self.messagesData = sortMessagesArray(messages: messages)
                
                DispatchQueue.main.async {
                    updateUI(messages, nil)
                }
            }
        }
    }
}
