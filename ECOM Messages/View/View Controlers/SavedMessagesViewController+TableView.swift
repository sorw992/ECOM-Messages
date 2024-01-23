//
//  Created by Soroush on 1/21/24.
//

import UIKit

extension SavedMessagesViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        switch savedMessageState {
        case .noResults:
            return 1
        case .results:
            return messageSavedViewModel.savedMessages.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch savedMessageState {
        case .noResults:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.noMessageCell, for: indexPath) as! NoMessageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case .results:
            if messageSavedViewModel.savedMessages[indexPath.row].fullText {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.messageFullCell, for: indexPath) as! MessageResultFullTableViewCell
                cell.configure(for: messageSavedViewModel.savedMessages[indexPath.row])
                
                let data = messageSavedViewModel.savedMessages[indexPath.row].imageData
                cell.msgImage.image = UIImage(data: data)
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.messageShortCell, for: indexPath) as! MessageResultShortTableViewCell
                cell.configure(for: messageSavedViewModel.savedMessages[indexPath.row])
                
                let data = messageSavedViewModel.savedMessages[indexPath.row].imageData
                cell.msgImage.image = UIImage(data: data)
                    
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch savedMessageState {
            
        case .noResults:
            return 335
            
        case .results:
            if messageSavedViewModel.savedMessages[indexPath.row].fullText == true {
                tableViewCellHeight = calculateCellHeight(title: messageSavedViewModel.savedMessages[indexPath.row].title ?? "", description: messageSavedViewModel.savedMessages[indexPath.row].description ?? "", fullDescriptionCell: true)
               
                return tableViewCellHeight
            } else {
                tableViewCellHeight = calculateCellHeight(title: messageSavedViewModel.savedMessages[indexPath.row].title ?? "", description: messageSavedViewModel.savedMessages[indexPath.row].description ?? "", fullDescriptionCell: false)
                
                return tableViewCellHeight
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch savedMessageState {
            
        case .noResults:
            return
            
        case .results:
            if messageSavedViewModel.savedMessages[indexPath.row].unread == true {
                messageSavedViewModel.savedMessages[indexPath.row].unread = false
            }
            
            messageSavedViewModel.savedMessages[indexPath.row].unread = false
            
            if messageSavedViewModel.savedMessages[indexPath.row].fullText == true {
                
                messageSavedViewModel.savedMessages[indexPath.row].fullText = false
                messageSavedViewModel.savedMessages = sortMessagesArray(messages: messageSavedViewModel.savedMessages )
                
            } else {
                messageSavedViewModel.savedMessages[indexPath.row].fullText = true
            }
            tableView.reloadData()
        }
    }
}
