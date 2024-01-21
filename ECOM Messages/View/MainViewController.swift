//
//  Created by Soroush on 1/20/24.
//

import UIKit


class MainViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: Variables
    private var subControllers: [UIViewController] = []
    
    let navBar = CustomNavBar()
    
    // MARK: Properties
    func viewPagerProperties() {
        viewPager.delegate = self
        viewPager.dataSource = self
        viewPager.hostController = self
        
        let inboxViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InboxViewController") as! InboxViewController
        let savedMessagesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SavedMessagesViewController") as! SavedMessagesViewController
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
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        .darkGray
    }
    
    // MARK: Actions


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.setUpCustomNavBar(view: self.view, navigationTitleText: "پیام های من")

        viewPagerProperties()
        
        
    }
    

  

}
