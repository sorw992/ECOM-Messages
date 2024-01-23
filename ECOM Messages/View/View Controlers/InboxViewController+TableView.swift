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
            return getMessageViewModel.messagesData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch messageResultState {
        case .noResults:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.noMessageCell, for: indexPath) as! NoMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingMessageCell, for: indexPath) as! LoadingMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case .results:
            
            
            if getMessageViewModel.messagesData[indexPath.row].fullText {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.messageFullCell, for: indexPath) as! MessageResultFullTableViewCell
                cell.configure(for: getMessageViewModel.messagesData[indexPath.row])
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.messageShortCell, for: indexPath) as! MessageResultShortTableViewCell
                
                cell.configure(for: getMessageViewModel.messagesData[indexPath.row])
                
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
            if getMessageViewModel.messagesData[indexPath.row].fullText == true {
                tableViewCellHeight = calculateCellHeight(title: getMessageViewModel.messagesData[indexPath.row].title ?? "", description: getMessageViewModel.messagesData[indexPath.row].description ?? "", fullDescriptionCell: true)
                
                return tableViewCellHeight
            } else {
                tableViewCellHeight = calculateCellHeight(title: getMessageViewModel.messagesData[indexPath.row].title ?? "", description: getMessageViewModel.messagesData[indexPath.row].description ?? "", fullDescriptionCell: false)
                
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
            if getMessageViewModel.messagesData[indexPath.row].unread == true {
                delegate?.userDidSeeMessage(badgeMinus: 1)
                getMessageViewModel.messagesData[indexPath.row].unread = false
            }
            
            getMessageViewModel.messagesData[indexPath.row].unread = false
            
            if getMessageViewModel.messagesData[indexPath.row].fullText == true {
                
                getMessageViewModel.messagesData[indexPath.row].fullText = false
                getMessageViewModel.messagesData = sortMessagesArray(messages: getMessageViewModel.messagesData )
                
            } else {
                getMessageViewModel.messagesData[indexPath.row].fullText = true
            }
            
            tableView.reloadData()
        }
    }
}
