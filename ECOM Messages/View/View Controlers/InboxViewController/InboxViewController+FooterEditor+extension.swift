//
//  InboxViewController.swift
//  ECOM Messages
//
//  Created by Soroush on 1/18/24.

import UIKit

extension InboxViewController: FooterEditorDelegate {
    
    // MARK: Footer Editor delegate
    func didTapDeleteButton() {
        if getMessageViewModel.removedMessagesArray.count != 0 {
            getMessageViewModel.removeSelectedElementsFromMessagesArray()
            tableView.reloadData()
        } else {
            alertView(viewController: self, title: "خطا", message: "لطفا حداقل ۱ پیام را انتخاب کنید")
        }
    }
    
    func didTapCancelButton() {
        getMessageViewModel.clearSelectedElementsForDelete()
        tableviewBottomConstaint.constant = 0
        if getMessageViewModel.messagesData.count > 0 {
            messageResultState = .results
            tableView.reloadData()
        }
        
    }
}
