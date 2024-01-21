//
//  Created by Soroush on 1/20/24.
//

import UIKit
import Combine
import BadgeGenerator



class MainViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource {
    
    // MARK: Outlets
    
    @IBOutlet weak var viewPager: LZViewPager!
    
    // MARK: Variables
    
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
    
    // MARK: Properties
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
            badgeLabel = button.setBadge(in: .northWest, with: "1")
            badgeLabel?.textColor = .white
        }
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        .darkGray
    }
    
    // MARK: Actions
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar.setUpCustomNavBar(view: self.view, navigationTitleText: "پیام های من")
        
        fetchMessageData()
        publisher.send()
        
        viewPagerProperties()
        
        //badgeLabel?.incrementIntValue(by: 2)
        
//        performSearch()
        
        
        
        
        
    }
    
    private func fetchMessageData() {
        getMessageViewModel.getMessagesListVM(messageData: publisher.eraseToAnyPublisher())
        
        getMessageViewModel.reloadMessageList
            .sink(receiveCompletion: { data in
                print("data100", data)
            }) { [weak self] _ in
                
                //self?.questionsTableView.reloadData()
                // print("messageData", self?.getMessageViewModel.messagesData)
                
                self?.inboxViewController.messages = self?.getMessageViewModel.messagesData
                
                self?.inboxViewController.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    
    
    private var dataTask: URLSessionDataTask? = nil

    func performSearch() {

            dataTask?.cancel()

            // Create the URL object using the search text
            let url = URL(string: "https://run.mocky.io/v3/4f4aff79-37c5-4392-9820-878f0cf6f5d9")
            
            // Get a shared URLSession instance, which uses the default configuration with respect to caching, cookies, and other web stuff.
            let session = URLSession.shared
            
            
        dataTask = session.dataTask(with: url!, completionHandler: { data, response, error in
                
                
                // Tip: If you want to determine via code whether a particular piece of code is being run on the main thread or not, add the following code snippet:
                print("Search.swift datatask On main thread? " + (Thread.current.isMainThread ? "Yes" : "No"))
                
               

                if let error = error as NSError?, error.code == -999 {
                    
                    print("Failure! \(error.localizedDescription)")
                    
                    return // search was cencelled
                    
                }
                
                // This unwraps the optional object from the data parameter
                if let httpResponse = response as? HTTPURLResponse,
                    
                    httpResponse.statusCode == 200, let data = data {
                    
                    print("Success! \(response!)")
                    
                    // print e.g: 300885 bytes
                    print("Success! \(data)")
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([MessageItem].self, from:data)
                        print("result! \(result)")
                    } catch {
                        print("JSON Error: \(error)")
                    }
                }

            })
        
            dataTask?.resume()

    }
     
    
}
