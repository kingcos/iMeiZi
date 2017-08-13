//
//  SettingsTableController.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit
import SafariServices
import PKHUD

class SettingsTableController: UITableViewController {
    
    @IBOutlet weak var clearCacheCell: UITableViewCell!
    
    let blogWebsite = "http://www.jianshu.com/u/b88081164fe8"

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }

}

extension SettingsTableController {
    func setup() {
        calculateCache { cacheSize in
            DispatchQueue.main.async {
                self.clearCacheCell.detailTextLabel?.text = cacheSize
            }
        }
    }
    
    func calculateCache(completion: @escaping (String) -> ()) {
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                            .userDomainMask,
                                                            true).first,
            let fileArray = FileManager.default.subpaths(atPath: cachePath) else { return }
        
        
        var size = 0
        for file in fileArray {
            let path = "\(cachePath)/\(file)"
            guard let folder = try? FileManager.default.attributesOfItem(atPath: path)
                else { return }
            for (key, value) in folder {
                if key == FileAttributeKey.size {
                    size += (value as AnyObject).integerValue
                }
            }
        }
        
        completion("\(size / 1024 / 1024) MB")
    }
    
    func clearCache(completion: @escaping () -> ()) {
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                                  .userDomainMask,
                                                                  true).first,
            let fileArray = FileManager.default.subpaths(atPath: cachePath) else { return }
        
        for file in fileArray {
            let path = "\(cachePath)/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                try? FileManager.default.removeItem(atPath: path)
            }
        }
        
        completion()
    }
}

// Table view settings
extension SettingsTableController {
    // Deselect the row when user did select a row with animation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let id = tableView.cellForRow(at: indexPath)?.reuseIdentifier else { return }
        
        switch id {
        case "clearCache":
            clearCache() {
                self.setup()
                HUD.flash(.success, delay: 1.0)
            }
        case "about":
            guard let url = URL(string: blogWebsite) else { return }
            let aboutContrller = SFSafariViewController(url: url)
            present(aboutContrller, animated: true)
        default:
            break
        }
        
        
    }
}
