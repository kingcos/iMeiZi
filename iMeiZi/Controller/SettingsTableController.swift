//
//  SettingsTableController.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit

class SettingsTableController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

// Table view settings
extension SettingsTableController {
    // Deselect the row when user did select a row with animation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
