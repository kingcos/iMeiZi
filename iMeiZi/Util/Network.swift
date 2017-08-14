//
//  Network.swift
//  iMeiZi
//
//  Created by kingcos on 13/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import Foundation

enum PhotoCategory: String {
    case all     = "All"
    case daXiong = "DaXiong"
    case meiTui  = "MeiTui"
    case qingXin = "QingXin"
    case zaHui   = "ZaHui"
    case qiaoTun = "QiaoTun"
    case heiSi   = "HeiSi"
}

struct Network {
    static func getWith(_ category: PhotoCategory, in page: Int, completion: @escaping (String) -> ()) {
        guard let url = URL(string: "https://meizi.leanapp.cn/category/\(category.rawValue)/page/\(page)")
            else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            guard let json = String(data: data, encoding: .utf8) else { return }
            
            completion(json)
        }
        
        task.resume()
    }
}
