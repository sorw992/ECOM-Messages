//
//  Created by Soroush on 1/19/24.

import Foundation

class GetMessageApiViewModel {
    
    var messagesData = [MessageItem]()
    var errorMessage = ""

    var removedMessagesArray = [MessageItem]()
    
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
                
                let uuidsSaved = SQLiteCommands.presentRows() ?? []
                
                
                self.messagesData = sortMessagesArray(messages: messages)

                
                self.messagesData = syncSaveStatus(arr1: self.messagesData, arr2: uuidsSaved, resetFirstArray: false)
                
                DispatchQueue.main.async {
                    updateUI(messages, nil)
                }
            }
        }
    }
    
    func refreshMessages() {
        messagesData = syncSaveStatus(arr1: messagesData, arr2: SQLiteCommands.presentRows() ?? [], resetFirstArray: true)
    }
    
    func clearSelectedElementsForDelete() {
        removedMessagesArray.removeAll()
        
        for i in messagesData.indices {
            messagesData[i].checked = false
        }
    }
    
    func removeSelectedElementsFromMessagesArray() {
        for i in (0..<messagesData.count).reversed() {
            if let _ = removedMessagesArray.lastIndex(where: {$0.uuid == messagesData[i].uuid}) {
                messagesData.remove(at: i)
            }
        }
        removedMessagesArray.removeAll()
    }
    func uncheckSelectedElementForRemove(messageElement: MessageItem) {
        
        removedMessagesArray = removedMessagesArray.filter {
            $0.uuid != messageElement.uuid
        }
        
    }
}
