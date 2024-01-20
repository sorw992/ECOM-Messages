//  Created by Soroush

import Foundation
import Combine

final class RequestMethod {
    enum Method: String {
        case GET
    }

    static func request(method: Method, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        // problem
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60
        return urlRequest
    }
}

enum NetworkError: LocalizedError {
    case someThingWrong
    case noInternet

    var errorDescription: String? {
        switch self {
        case .someThingWrong:
            return "Something went wrong"
        case .noInternet:
            return "Please check your Internet Connection"
        }
    }
}

class RequestManager {

    static let sharedService = RequestManager()

    func requestAPI<T: Decodable>(requestType: RequestMethod.Method, urlString: String) -> AnyPublisher<T, NetworkError> {
    

        print("URL =====>\(urlString)")
        guard let url = URL(string: urlString) else {
            print("Something went wrong")
            // A publisher that immediately terminates with the specified error.
            return Fail(error: NetworkError.someThingWrong).eraseToAnyPublisher()
        }
    
        let urlRequest = RequestMethod.request(method: requestType, url: url)
       
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
        // problem
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: NetworkError.someThingWrong).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}
