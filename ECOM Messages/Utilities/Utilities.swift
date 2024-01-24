//
//  Created by Soroush on 1/22/24.
//

import Foundation

func sortMessagesArray(messages: [MessageItem]) -> [MessageItem] {
    return messages
    // sort by descending uuid
        .sorted { $1.uuid?.lowercased() ?? "" < $0.uuid?.lowercased() ?? "" }
    // sort by unread messages
        .sorted { $0.unread ?? false && !($1.unread ?? false) }
}

func syncSaveStatus(arr1: [MessageItem], arr2: [MessageItem], resetFirstArray: Bool) -> [MessageItem] {
    
    var output = arr1
    
    output = sortMessagesArray(messages: arr1)
    
    if resetFirstArray == true {
        for i in 0..<output.count {
            output[i].isSaved = false
        }
    }
    
    
    for i in 0..<output.count {
        //messages.filter { $0.uuid == messages[i].uuid }.first?.isSaved = true
        if let _ = arr2.firstIndex(where: {$0.uuid == arr1[i].uuid}) {
            output[i].isSaved = true
        }
    }
    
    
    return output
}
