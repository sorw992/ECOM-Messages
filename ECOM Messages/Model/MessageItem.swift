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
    var imageData = Data()
    let uuid: String?
    var unread: Bool?
    var fullText = false
    var isSaved = false
    var checked = false
    
    private enum CodingKeys: String, CodingKey {
            case title, description, imageUrl = "image", uuid, unread
    }
    
}


