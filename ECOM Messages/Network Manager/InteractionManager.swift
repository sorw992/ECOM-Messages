//  Created by Soroush

import Foundation
import Combine

struct InteractionManager {

    func getMessagesListIM() -> AnyPublisher<[MessageItem], NetworkError> {
        let url = APIURL.fullUrl.apiString
        let placeResponsePublisher: AnyPublisher<[MessageItem], NetworkError> = RequestManager.sharedService.requestAPI(requestType: .GET, urlString: url)
        return placeResponsePublisher
            .map { $0 }
            .eraseToAnyPublisher()
    }
}
