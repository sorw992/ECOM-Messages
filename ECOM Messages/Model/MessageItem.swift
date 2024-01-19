//
//  File.swift
//  ECOM Messages
//
//  Created by Soroush on 1/19/24.
//

import Foundation

struct MessageItem: Codable {
    let title: String?
    let description: String?
    let imageUrl: String?
    let uuid: String?
    let unread: Bool?
}
