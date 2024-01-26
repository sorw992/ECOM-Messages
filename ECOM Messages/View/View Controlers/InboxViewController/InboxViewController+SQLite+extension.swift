//
//  Created by Soroush on 1/18/24.

import UIKit


extension InboxViewController: SaveMessageDelegate {
    
    // MARK: - SQLite Database
    func loadData() {
        messageSavedViewModel.loadDataFromSQLiteDatabase()

        getMessageViewModel.messagesData = syncSaveStatus(arr1: getMessageViewModel.messagesData, arr2:  messageSavedViewModel.savedMessages, resetFirstArray: true)
    }
    
    // MARK: - Connect to database and create table.
     func createDatabaseTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    // MARK: table view cell delegate
    func btnSaveTapped(messageItem: MessageItem, index: Int) {
       
        // update isSaved property of MessageItem
        if getMessageViewModel.messagesData[index].isSaved == false {
            getMessageViewModel.messagesData[index].isSaved = true
            let _ = SQLiteCommands.insertRow(messageItem)
        } else {
            getMessageViewModel.messagesData[index].isSaved = false
            SQLiteCommands.deleteRow(messageId: messageItem.uuid ?? "")
        }
        messageSavedViewModel.loadDataFromSQLiteDatabase()
        tableView.reloadData()
    }
}
