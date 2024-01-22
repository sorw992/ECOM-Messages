//
//  InboxViewController.swift
//  ECOM Messages
//
//  Created by Soroush on 1/18/24.

import UIKit
import Combine

extension InboxViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch messageResultState {
            
        case .noResults:
            return 1
            
        case .loading:
            return 1
            
        case .results:
            return messages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch messageResultState {
        case .noResults:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMessageCell", for: indexPath) as! NoMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingMessageCell", for: indexPath) as! LoadingMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case .results:
            
            
            if messages[indexPath.row].fullText {
                let cell = tableView.dequeueReusableCell(withIdentifier: "messageFullCell", for: indexPath) as! MessageResultFullTableViewCell
                cell.configure(for: messages[indexPath.row])
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "messageShortCell", for: indexPath) as! MessageResultShortTableViewCell
                cell.configure(for: messages[indexPath.row])
                
                return cell
            }
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        switch messageResultState {
            
        case .noResults:
            return 335
            
        case .loading:
            return 113
            
        case .results:
            if messages[indexPath.row].fullText == true {
                tableViewCellHeight = calculateCellHeight(title: messages[indexPath.row].title ?? "", description: messages[indexPath.row].description ?? "", fullDescriptionCell: true)
                print(tableViewCellHeight)
                return tableViewCellHeight
            } else {
                tableViewCellHeight = calculateCellHeight(title: messages[indexPath.row].title ?? "", description: messages[indexPath.row].description ?? "", fullDescriptionCell: false)
                print(tableViewCellHeight)
                return tableViewCellHeight
            }
        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        switch messageResultState {
            
        case .noResults:
            return
            
        case .loading: break
            
        case .results:
            if messages[indexPath.row].unread == true {
                delegate?.userDidSeeMessage(badgeMinus: 1)
                messages[indexPath.row].unread = false
            }
            
            messages[indexPath.row].unread = false
            
            if messages[indexPath.row].fullText == true {
                
                messages[indexPath.row].fullText = false
                messages = sortMessagesArray(messages: messages )
                
            } else {
                messages[indexPath.row].fullText = true
            }
            
            tableView.reloadData()
        }
        
       
        
        
    }
}
