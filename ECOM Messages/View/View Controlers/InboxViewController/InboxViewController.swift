//
//  Created by Soroush on 1/18/24.

import UIKit

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableviewBottomConstaint: NSLayoutConstraint!
    
    var tableViewCellHeight: CGFloat = 0
    
    var getMessageViewModel = GetMessageApiViewModel()
    var messageSavedViewModel = MessageSavedViewModel()
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
        
        footerEditor.delegate = self
        
        getMessagesFromApi()
        createDatabaseTable()
        
        // setup table view long press
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        tableView.addGestureRecognizer(longPress)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        getMessageViewModel.refreshMessages()
        tableView.reloadData()
    }
    
    func getMessagesFromApi() {
        messageResultState = .loading
        
        getMessageViewModel.fetchData { [weak self] messages, error in
            
            guard let weakSelf = self else { return }
            
            if error != nil {
                weakSelf.messageResultState = .noResults
                weakSelf.tableView.reloadData()
                
                alertViewGetApiError(viewController: weakSelf, title: "Error", message: error ?? "Try Again") {
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
    
    // MARK: Table View long press gesture
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: tableView)
            if tableView.indexPathForRow(at: touchPoint) != nil {
                
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
