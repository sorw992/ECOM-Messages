//
//  Created by Soroush on 1/21/24.
//

import UIKit

class SavedMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var savedMessageState: SavedMessageState = .noResults
    
    private var messageSavedViewModel = MessageSavedViewModel()

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
        tableView.register(noMessageCellNib, forCellReuseIdentifier: "noMessageCell")
        
        let messageShortCellNib = UINib(nibName: "MessageResultShortTableViewCell", bundle: nil)
        tableView.register(messageShortCellNib, forCellReuseIdentifier: "messageShortCell")
        
        let messageFullCellNib = UINib(nibName: "MessageResultFullTableViewCell", bundle: nil)
        tableView.register(messageFullCellNib, forCellReuseIdentifier: "messageFullCell")
        
        let messageArray = SQLiteCommands.presentRows() ?? []
        print("messageArray", messageArray)
        print("messageArray", messageArray.count)


    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        switch savedMessageState {
        case .noResults:
            return 1
        case .results:
            return messageSavedViewModel.savedMessages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch savedMessageState {
        case .noResults:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMessageCell", for: indexPath) as! NoMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
            
        case .results:
            if messageSavedViewModel.savedMessages[indexPath.row].fullText {
                let cell = tableView.dequeueReusableCell(withIdentifier: "messageFullCell", for: indexPath) as! MessageResultFullTableViewCell
                cell.configure(for: messageSavedViewModel.savedMessages[indexPath.row])
                
                let data = messageSavedViewModel.savedMessages[indexPath.row].imageData
                cell.msgImage.image = UIImage(data: data)
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "messageShortCell", for: indexPath) as! MessageResultShortTableViewCell
                cell.configure(for: messageSavedViewModel.savedMessages[indexPath.row])
                
                let data = messageSavedViewModel.savedMessages[indexPath.row].imageData
                cell.msgImage.image = UIImage(data: data)
                    
                return cell
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    }

}
