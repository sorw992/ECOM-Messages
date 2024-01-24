//
//  protocols.swift
//  ECOM Messages
//
//  Created by macbookpro13 on 1/24/24.
//

import Foundation


protocol BadgeChangeDelegate {
    func userDidSeeMessage(badgeMinus: Int)
    func passBadgeCount(count: Int)
}

protocol SaveMessageDelegate {
    func btnSaveTapped(messageItem: MessageItem, index: Int)
}
