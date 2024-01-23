//
//  Created by Soroush
//

import Foundation
import SQLite

class SQLiteCommands {
    
    static var table = Table("message")
    
    // Expressions
    static let uuid = Expression<String>("uuid")
    static let title = Expression<String>("title")
    static let description1 = Expression<String>("description1")
    static let imageUrl = Expression<String>("imageurl")

    static let photo = Expression<Data>("photo")
    
    // Creating Table
    static func createTable1() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(uuid, primaryKey: true)
                table.column(title)
                table.column(description1)
                table.column(imageUrl)
                table.column(photo)
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    
    static func insertRow1(_ messageValues: MessageItem) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            
            try database.run(table.insert(title <- messageValues.title!, description1 <- messageValues.description!, imageUrl <- messageValues.imageUrl!,  photo <- messageValues.imageData))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    
    // Creating Table
    static func createTable() {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            // ifNotExists: true - Will NOT create a table if it already exists
            try database.run(table.create(ifNotExists: true) { table in
                table.column(uuid, primaryKey: true)
                table.column(title)
                table.column(description1)
                table.column(imageUrl)
                table.column(photo)
                
            })
        } catch {
            print("Table already exists: \(error)")
        }
    }
    
    // Inserting Row
    static func insertRow(_ messageValues: MessageItem) -> Bool? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
        do {
            
            try database.run(table.insert(title <- messageValues.title ?? "", uuid <- messageValues.uuid ?? "", description1 <- messageValues.description ?? "", imageUrl <- messageValues.imageUrl ?? "", photo <- messageValues.imageData ))
            return true
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
        } catch let error {
            print("Insertion failed: \(error)")
            return false
        }
    }
    
    
    
    // Present Rows
    
    static func presentRows() -> [MessageItem]? {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return nil
        }
        
      
        var messageArray = [MessageItem]()
        
        // Sorting data in descending order by ID
        table = table.order(uuid.desc)
        
        do {
            for message in try database.prepare(table) {
                
                let uuidValue = message[uuid]
                let titleValue = message[title]
                let descriptionValue = message[description1]
                let imageUrlValue = message[imageUrl]
                let photoValue = message[photo]
                
               
                
                // Create object
                let messageObject = MessageItem(title: titleValue, description: descriptionValue, imageUrl: imageUrlValue, imageData: photoValue, uuid: uuidValue, unread: false, fullText: false)
                
                // Add object to an array
                messageArray.append(messageObject)
                
//                print("uuid \(message[uuid]), title: \(message[title])")
            }
        } catch {
            print("Present row error: \(error)")
        }
        return messageArray
    }
    
    
    // Delete Row
    static func deleteRow(messageId: String) {
        guard let database = SQLiteDatabase.sharedInstance.database else {
            print("Datastore connection error")
            return
        }
        
        do {
            let message = table.filter(uuid == messageId).limit(1)
            try database.run(message.delete())
        } catch {
            print("Delete row error: \(error)")
        }
    }
}
