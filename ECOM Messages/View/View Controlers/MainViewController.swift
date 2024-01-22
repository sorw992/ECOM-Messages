//
//  Created by Soroush on 1/20/24.
//

import UIKit
import Combine
import BadgeGenerator

class MainViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: Properties
    private var getMessageViewModel = GetMessageViewModel()
    // Subject: A subject acts as a go-between to enable non-Combine imperative code to send values to Combine subscribers.
    // PassthroughSubject: Creates an instance of a PassthroughSubject of type Void and never fail.
    private var publisher = PassthroughSubject<Void,Never>()
    private var subscriptions = Set<AnyCancellable>()
    
    private var subControllers: [UIViewController] = []
    
    let navBar = CustomNavBar()
    
    var badgeLabel: BadgeLabel? = nil
    
    let inboxViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InboxViewController") as! InboxViewController
    let savedMessagesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavedMessagesViewController") as! SavedMessagesViewController
    
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
        
        fetchMessageData()
        publisher.send()
        
        viewPagerProperties()
    }
    
    private func fetchMessageData() {
        getMessageViewModel.getMessagesListVM(messageData: publisher.eraseToAnyPublisher())
        
        getMessageViewModel.reloadMessageList
            .sink(receiveCompletion: { data in
                print("data100", data)
            }) { [weak self] _ in
                
                self?.inboxViewController.messages = self?.getMessageViewModel.messagesData
                
                let unreadMessagesCount = self?.getMessageViewModel.messagesData.filter{ $0.unread ?? false }.count
                
                if let unreadMessagesCount {
                    self?.badgeLabel?.incrementIntValue(by: unreadMessagesCount)
                }
                                
                self?.inboxViewController.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}
