//
//  Created by Soroush
//

import Foundation

class MessageSavedViewModel {
    
     var savedMessages = [MessageItem]()
    
    func connectToDatabase() {
        _ = SQLiteDatabase.sharedInstance
    }
    
    func loadDataFromSQLiteDatabase() {
        savedMessages = SQLiteCommands.presentRows() ?? []
    }
    
    
}
