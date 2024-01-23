//
//  Created by Soroush on 1/20/24.
//

import UIKit
import BadgeGenerator

class MainViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource, BadgeChangeDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: Properties

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
    
    // MARK: badge Functins
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
    
    func userDidSeeMessage(badgeMinus: Int) {
        unreadMessagesCount = unreadMessagesCount - badgeMinus
        
        if unreadMessagesCount == 0 {
            self.badgeLabel?.remove()
        }
        self.badgeLabel?.set("\(unreadMessagesCount)")
    }
    
    func passBadgeCount(count: Int) {
        unreadMessagesCount = count
        self.badgeLabel?.incrementIntValue(by: count)
    }
    
    // MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.setUpCustomNavBar(view: self.view, navigationTitleText: "پیام های من")
        
        inboxViewController.delegate = self
    
        viewPagerProperties()
    }
}
