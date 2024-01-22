//
//  Created by Soroush on 1/22/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var dataTask: URLSessionDataTask? = nil

    func getApiMessages(completion: @escaping ([MessageItem]?, NSError?) -> Void) {

            dataTask?.cancel()

            let url = APIURL.fullUrl.apiString
            
            let session = URLSession.shared
            
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in

                if let error = error as NSError? {
                    
                    print("Failure! \(error.localizedDescription)")
                   
                        completion(nil, error)
                    
                    return
                }
               
                if let httpResponse = response as? HTTPURLResponse,
                    
                    httpResponse.statusCode == 200, let data = data {
                    
                    //print("Success! \(response!)")
                    //print("Success! \(data)")
                    
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([MessageItem].self, from:data)
                        
                    
                        completion(result, nil)

                    } catch {
                        print("JSON Error: \(error)")
                    }
                }

            })
        
            dataTask?.resume()
    }
}
