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
