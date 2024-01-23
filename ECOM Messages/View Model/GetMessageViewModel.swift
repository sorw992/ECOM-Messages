//
//  Created by Soroush on 1/19/24.

import Foundation

class GetMessageViewModel {
    
    var messagesData = [MessageItem]()
    var errorMessage = ""
    
    func fetchData(updateUI: @escaping ([MessageItem]?, String?) -> Void) {
        
        NetworkManager.shared.getApiMessages { messages, error in
            
            
            
            if let error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    updateUI(nil, self.errorMessage)
                }
            }
            
            if var messages {
                
                for i in 0..<messages.count {
                    
                    if let data = try? Data(contentsOf: URL(string: messages[i].imageUrl ?? "")!) {
                        messages[i].imageData = data
                    }
                    
                }
                
                self.messagesData = sortMessagesArray(messages: messages)
                
                DispatchQueue.main.async {
                    updateUI(messages, nil)
                }
            }
        }
    }
}
