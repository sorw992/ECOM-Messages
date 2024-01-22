//
//  Created by Soroush on 1/20/24.
//

import UIKit
import BadgeGenerator

class MainViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource, BadgeChangeDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: Properties
    private var getMessageViewModel = GetMessageViewModel()

    private var subControllers: [UIViewController] = []
    
    let navBar = CustomNavBar()
    
    var badgeLabel: BadgeLabel? = nil
    
    let inboxViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InboxViewController") as! InboxViewController
    let savedMessagesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavedMessagesViewController") as! SavedMessagesViewController
    
    var unreadMessagesCount = 0
    
    // MARK: functions
    func viewPagerProperties() {
        viewPager.delegate = self
        viewPager.dataSource = self
        viewPager.hostController = self
        
        inboxViewController.title = "عمومی"
        savedMessagesViewController.title = "ذخیره شده"
        subControllers = [savedMessagesViewController, inboxViewController]
        
        viewPager.reload()
    }
    
    func numberOfItems() -> Int {
        self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor(red: 213/255.0, green: 246/255.0, blue: 254/255.0, alpha: 1.0)
        
        if index == 1 {
            badgeLabel = button.setBadge(in: .northWest, with: "0")
            badgeLabel?.textColor = .white
        }
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        .darkGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.setUpCustomNavBar(view: self.view, navigationTitleText: "پیام های من")
        
        inboxViewController.delegate = self
    
        getMessages()
        
        viewPagerProperties()
    }
    
    private func getMessages() {
        
        self.inboxViewController.messageResultState = .loading
        
        getMessageViewModel.fetchData { [weak self] messages, error in
            
            if let error = error {
                print("error1000", error)
                
                self?.inboxViewController.messageResultState = .noResults
                self?.inboxViewController.tableView.reloadData()
                
                return
            }
            
            if let messageData = self?.getMessageViewModel.messagesData {
                self?.inboxViewController.messages = messageData
            }
            
            self?.unreadMessagesCount = self?.getMessageViewModel.messagesData.filter{ $0.unread ?? false }.count ?? 0
           
            self?.badgeLabel?.incrementIntValue(by: self?.unreadMessagesCount ?? 0)
            
            self?.inboxViewController.messageResultState = .results
            
            self?.inboxViewController.tableView.reloadData()
        }

    }
        
    func userDidSeeMessage(badgeMinus: Int) {
        unreadMessagesCount = unreadMessagesCount - badgeMinus
        if unreadMessagesCount == 0 {
            self.badgeLabel?.remove()
        }
        self.badgeLabel?.set("\(unreadMessagesCount)")
    }
}
