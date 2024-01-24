//
//  Created by Soroush on 1/18/24.

import UIKit



class InboxViewController: UIViewController, SaveMessageDelegate, FooterEditorDelegate, CheckBoxDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableviewBottomConstaint: NSLayoutConstraint!
    
    var tableViewCellHeight: CGFloat = 0
    
     var getMessageViewModel = GetMessageApiViewModel()
    
    private var messageSavedViewModel = MessageSavedViewModel()
    
     var delegate: BadgeChangeDelegate?

    var messageResultState: MessageResultState = .noResults
    
    let footerEditor = FooterEditor()
        
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
        
        getMessagesFromApi()
        
        createDatabaseTable()
        
        footerEditor.delegate = self
        
        // setup table view long press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
    }
   
    

    override func viewWillAppear(_ animated: Bool) {
        loadData()
        getMessageViewModel.refreshMessages()
        tableView.reloadData()
        
    }
    
    // MARK: - SQLite Database
    private func loadData() {
        messageSavedViewModel.loadDataFromSQLiteDatabase()

        getMessageViewModel.messagesData = syncSaveStatus(arr1: getMessageViewModel.messagesData, arr2:  messageSavedViewModel.savedMessages, resetFirstArray: true)
    }
    
    // MARK: - Connect to database and create table.
    private func createDatabaseTable() {
        let database = SQLiteDatabase.sharedInstance
        database.createTable()
    }
    
    // MARK: table view cell delegate
    func btnSaveTapped(messageItem: MessageItem, index: Int) {
       
        // update isSaved property of MessageItem
        if getMessageViewModel.messagesData[index].isSaved == false {
            getMessageViewModel.messagesData[index].isSaved = true
            SQLiteCommands.insertRow(messageItem)
        } else {
            getMessageViewModel.messagesData[index].isSaved = false
            SQLiteCommands.deleteRow(messageId: messageItem.uuid ?? "")
        }
        messageSavedViewModel.loadDataFromSQLiteDatabase()
        tableView.reloadData()
    }
    
     func getMessagesFromApi() {
        
        messageResultState = .loading
        
        getMessageViewModel.fetchData { [weak self] messages, error in
            
            guard let weakSelf = self else { return }
            
            if error != nil {
                weakSelf.messageResultState = .noResults
                weakSelf.tableView.reloadData()
                
                alertView(viewController: weakSelf, title: "Error", message: "Try Again") {
                    self?.getMessagesFromApi()
                    
                    self?.tableView.reloadData()
                }
                
                return
            }
            
            if let messages {
                let unreadMessagesCount = messages.filter{ $0.unread ?? false }.count
           
                weakSelf.delegate?.passBadgeCount(count: unreadMessagesCount)
                
                weakSelf.messageResultState = .results
                
                weakSelf.tableView.reloadData()
                //self?.saveListItems()
            }
        }
    }
    
    func removeSelectedElementsFromMessagesArray() {
        for i in (0..<getMessageViewModel.messagesData.count).reversed() {
            if let _ = getMessageViewModel.removedMessagesArray.lastIndex(where: {$0.uuid == getMessageViewModel.messagesData[i].uuid}) {
                getMessageViewModel.messagesData.remove(at: i)
            }
        }
    }
    
    // MARK: Footer Editor delegate
    func didTapDeleteButton() {
        removeSelectedElementsFromMessagesArray()
    
        tableView.reloadData()
        
    }
    
    func didTapCancelButton() {
        getMessageViewModel.removedMessagesArray = []
        tableviewBottomConstaint.constant = 0
        if getMessageViewModel.messagesData.count > 0 {
            messageResultState = .results
            tableView.reloadData()
        }
        
    }
    
    // MARK: checkbox delegate
    func checkBoxTapped(messageItem: MessageItem, checked: Bool, index: Int) {
        
        getMessageViewModel.messagesData[index].checked = checked
        
        // add to removedMessagesArray
        getMessageViewModel.removedMessagesArray.append(messageItem)
        print(getMessageViewModel.removedMessagesArray)
        tableView.reloadData()
        
    }
    
    // MARK: Table View long press gesture
   
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                print("long press")
                
                
                if getMessageViewModel.messagesData.count > 0 {
                    messageResultState = .editMode
                    tableviewBottomConstaint.constant = 50
                    self.footerEditor.setupFooterEditor(view: self.view, navigationTitleText: "پیام های من")
                }
                
                tableView.reloadData()
                
            }
        }
    }
}
