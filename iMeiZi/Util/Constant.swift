//
//  Constant.swift
//  iMeiZi
//
//  Created by kingcos on 14/08/2017.
//  Copyright © 2017 kingcos. All rights reserved.
//

import UIKit

let PHOTOS_COLLUMNS: CGFloat = 3.0

let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height

let PHOTOS_LINE_SPACE: CGFloat = 3.0
let PHOTOS_COLLECTION_ITEM_WIDTH: CGFloat = (SCREEN_WIDTH - ((PHOTOS_COLLUMNS - 1) * PHOTOS_LINE_SPACE)) / PHOTOS_COLLUMNS
let PHOTOS_COLLECTION_ITEM_HEIGHT: CGFloat = PHOTOS_COLLECTION_ITEM_WIDTH

let PHOTO_CELL_ID = "PHOTO_CELL_ID"
