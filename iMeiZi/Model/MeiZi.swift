//
//  MeiZi.swift
//  iMeiZi
//
//  Created by kingcos on 14/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import Foundation
import HandyJSON

struct Result: HandyJSON {
    var category: String?
    var page: Int?
    var results: [MeiZi]?
}

struct MeiZi: HandyJSON {
    var category: String?
    var groupURL: String?
    var imageURL: String?
    var objectId: String?
    var thumbURL: String?
    var title: String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<< self.groupURL <-- "group_url"
        mapper <<< self.imageURL <-- "image_url"
        mapper <<< self.thumbURL <-- "thumb_url"
    }
}
