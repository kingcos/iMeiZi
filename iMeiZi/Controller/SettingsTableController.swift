//
//  SettingsTableController.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import SafariServices

class SettingsTableController: UITableViewController {
    
    let blogWebsite = "http://www.jianshu.com/u/b88081164fe8"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// Table view settings
extension SettingsTableController {
    // Deselect the row when user did select a row with animation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == "about" {
            guard let url = URL(string: blogWebsite) else { return }
            let aboutContrller = SFSafariViewController(url: url)
            present(aboutContrller, animated: true)
        }
    }
}
