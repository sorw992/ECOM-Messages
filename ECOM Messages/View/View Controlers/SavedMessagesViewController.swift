//
//  Created by Soroush on 1/21/24.
//

import UIKit

class SavedMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var savedMessageState: SavedMessageState = .noResults
    
    var messageSavedViewModel = MessageSavedViewModel()
    
    var tableViewCellHeight: CGFloat = 0

    // MARK: - SQLite Database
    private func loadData() {
        messageSavedViewModel.loadDataFromSQLiteDatabase()
        if messageSavedViewModel.savedMessages.count != 0 {
            savedMessageState = .results
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noMessageCellNib = UINib(nibName: "NoMessageTableViewCell", bundle: nil)
        tableView.register(noMessageCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.noMessageCell)
        
        let messageShortCellNib = UINib(nibName: "MessageResultShortTableViewCell", bundle: nil)
        tableView.register(messageShortCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.messageShortCell)
        
        let messageFullCellNib = UINib(nibName: "MessageResultFullTableViewCell", bundle: nil)
        tableView.register(messageFullCellNib, forCellReuseIdentifier: TableView.CellIdentifiers.messageFullCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
}
