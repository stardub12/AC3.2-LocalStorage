//
//  BlockGround.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

internal struct BlockGroundKey {
  static let short_name: String = "short_name"
  static let record_url: String = "record_url"
  static let imageFullRes: String = "img_full_res"
  static let originalURL: String = "original_url"
  static let title: String = "title"
}

internal struct BlockGround: JSONConvertible {
  let shortName: String
  let title: String
  let originalURL: URL
  let imageFullResURL: String
  
  init(shortName: String, title: String, originalURL: String, imageFullResURL: String) {
    self.shortName = shortName
    self.title = title
    self.originalURL = URL(string: originalURL)!
    self.imageFullResURL = imageFullResURL
  }
  
  init?(json: [String : AnyHashable]) {
    guard let
      bgName: String = json[BlockGroundKey.short_name] as? String,
      let bgTitle: String = json[BlockGroundKey.title] as? String,
      let bgOriginalURL: String = json[BlockGroundKey.originalURL] as? String,
      let bgImageFullResURL: String = json[BlockGroundKey.imageFullRes] as? String
    else {
        return nil
    }
    
    self = BlockGround(shortName: bgName, title: bgTitle, originalURL: bgOriginalURL, imageFullResURL: bgImageFullResURL)
  }
  
  func toJson() -> [String : AnyHashable] {
    return [String : AnyHashable]()
  }
  
}
