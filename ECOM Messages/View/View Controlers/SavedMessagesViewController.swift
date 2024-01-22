//
//  Created by Soroush on 1/21/24.
//

import UIKit

class SavedMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noMessageCell", for: indexPath) as! NoMessageTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 335
    }
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noMessageCellNib = UINib(nibName: "NoMessageTableViewCell", bundle: nil)
        tableView.register(noMessageCellNib, forCellReuseIdentifier: "noMessageCell")

    }
    

}
