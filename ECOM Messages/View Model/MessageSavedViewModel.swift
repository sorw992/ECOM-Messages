//
//  ContactScreenViewModel.swift
//  ContactList
//
//  Created by Niso on 1/27/21.
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
