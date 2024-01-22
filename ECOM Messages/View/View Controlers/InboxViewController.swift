//
//  InboxViewController.swift
//  ECOM Messages
//
//  Created by Soroush on 1/18/24.

import UIKit

protocol BadgeChangeDelegate {
    func userDidSeeMessage(badgeMinus: Int)
}

class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var messages: [MessageItem] = []
    var tableViewCellHeight: CGFloat = 0
    
     var delegate: BadgeChangeDelegate?
    
    
    var messageResultState: MessageResultState = .noResults
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 244/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
        tableView.separatorStyle = .none
//        tableView.allowsSelection = false 
        
        
        let messageFullCellNib = UINib(nibName: "MessageResultFullTableViewCell", bundle: nil)
        tableView.register(messageFullCellNib, forCellReuseIdentifier: "messageFullCell")
        
        let noMessageCellNib = UINib(nibName: "NoMessageTableViewCell", bundle: nil)
        tableView.register(noMessageCellNib, forCellReuseIdentifier: "noMessageCell")
        
        let loadingMessageCellNib = UINib(nibName: "LoadingMessageTableViewCell", bundle: nil)
        tableView.register(loadingMessageCellNib, forCellReuseIdentifier: "loadingMessageCell")
    }
    
    
    
    
}
