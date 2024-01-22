//  Created by Soroush

import Foundation

enum APIURL {
    static let baseUrl = "https://run.mocky.io"
    static let apiPath = "/v3"
    static let apiKey = "/4f4aff79-37c5-4392-9820-878f0cf6f5d9"
    
    case fullUrl
    
    var apiString: URL {
        switch self {
        case .fullUrl:
            return URL(string: APIURL.baseUrl + APIURL.apiPath + APIURL.apiKey)!
        }
    }
}
