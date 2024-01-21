//
//  InboxViewController.swift
//  ECOM Messages
//
//  Created by Soroush on 1/18/24.

import UIKit


class InboxViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [MessageItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 244/255.0, green: 249/255.0, blue: 250/255.0, alpha: 1.0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false        
        
    }
    
    
    
    /*
    private var dataTask: URLSessionDataTask? = nil

    func performSearch() {

            dataTask?.cancel()

            // Create the URL object using the search text
            let url = URL(string: "https://run.mocky.io/v3/4f4aff79-37c5-4392-9820-878f0cf6f5d9")
            
            // Get a shared URLSession instance, which uses the default configuration with respect to caching, cookies, and other web stuff.
            let session = URLSession.shared
            
            
        dataTask = session.dataTask(with: url!, completionHandler: { data, response, error in
                
                
                // Tip: If you want to determine via code whether a particular piece of code is being run on the main thread or not, add the following code snippet:
                print("Search.swift datatask On main thread? " + (Thread.current.isMainThread ? "Yes" : "No"))
                
               

                if let error = error as NSError?, error.code == -999 {
                    
                    print("Failure! \(error.localizedDescription)")
                    
                    return // search was cencelled
                    
                }
                
                // This unwraps the optional object from the data parameter
                if let httpResponse = response as? HTTPURLResponse,
                    
                    httpResponse.statusCode == 200, let data = data {
                    
                    print("Success! \(response!)")
                    
                    // print e.g: 300885 bytes
                    print("Success! \(data)")
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([MessageItem].self, from:data)
                        print("result! \(result)")
                    } catch {
                        print("JSON Error: \(error)")
                    }
                }

            })
        
            dataTask?.resume()

    }
     */
}
