//
//  Created by Soroush on 1/18/24.

import UIKit

protocol BadgeChangeDelegate {
    func userDidSeeMessage(badgeMinus: Int)
    func passBadgeCount(count: Int)
}

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
   
    var tableViewCellHeight: CGFloat = 0
    
     var getMessageViewModel = GetMessageViewModel()
    
    private var messageSavedViewModel = MessageSavedViewModel()
    
     var delegate: BadgeChangeDelegate?
    
    var messageResultState: MessageResultState = .noResults
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor(red: 244/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
        tableView.separatorStyle = .none
        
        let messageShortCellNib = UINib(nibName: "MessageResultShortTableViewCell", bundle: nil)
        tableView.register(messageShortCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.messageShortCell)
        
        let messageFullCellNib = UINib(nibName: "MessageResultFullTableViewCell", bundle: nil)
        tableView.register(messageFullCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.messageFullCell)
        
        let noMessageCellNib = UINib(nibName: "NoMessageTableViewCell", bundle: nil)
        tableView.register(noMessageCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.noMessageCell)
        
        let loadingMessageCellNib = UINib(nibName: "LoadingMessageTableViewCell", bundle: nil)
        tableView.register(loadingMessageCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingMessageCell)
        
        getMessages()
        
        createDatabaseTable()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    // MARK: - SQLite Database
    private func loadData() {
        messageSavedViewModel.loadDataFromSQLiteDatabase()
    }
    
    // MARK: - Connect to database and create table.
    private func createDatabaseTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    private func getMessages() {
        
        messageResultState = .loading
        
        getMessageViewModel.fetchData { [weak self] messages, error in
            
            if error != nil {
                self?.messageResultState = .noResults
                self?.tableView.reloadData()
                return
            }
            
            if let messages {
                let unreadMessagesCount = messages.filter{ $0.unread ?? false }.count
           
                self?.delegate?.passBadgeCount(count: unreadMessagesCount)
                
                self?.messageResultState = .results
                
                self?.tableView.reloadData()
                //self?.saveListItems()
            }
        }
    }
    
}
