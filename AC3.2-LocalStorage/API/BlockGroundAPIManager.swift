//
//  BlockGroundAPIManager.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct BlockGroundConstant {
  static let notSet = "Not Set"
  static let baseURL = "https://api.fieldbook.com/v1/"
  static let imageEndPoint = "/images"
}

internal class BlockGroundAPIManager {
  private var bookId: String
  private var baseURL: String
  private let session: URLSession = URLSession(configuration: .default)
  
  static let shared: BlockGroundAPIManager = BlockGroundAPIManager()
  private init() {
    bookId = BlockGroundConstant.notSet
    baseURL = BlockGroundConstant.baseURL
  }
  
  internal func configure(bookId: String, baseURL: String = BlockGroundConstant.baseURL) {
    self.bookId = bookId
    self.baseURL = baseURL
  }
  
  internal func requestAllBlockGrounds(completion: @escaping ([BlockGround]?, Error?)->Void) {
    
    let url = URL(string: baseURL + bookId + BlockGroundConstant.imageEndPoint)!
    session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      
      if error != nil {
        print("Error: \(error!)")
        completion(nil, error)
        return
      }
      
      if data != nil {
        
        do {
          
          let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String : AnyHashable]]
          guard let validJSONDict = json else { return }
          
          var allBlockGrounds: [BlockGround] = []
          for blockGround in validJSONDict {
            guard let validBlockGround = BlockGround(json: blockGround) else { continue }
            allBlockGrounds.append(validBlockGround)
          }
          
          completion(allBlockGrounds, nil)
        }
        catch {
          print("Error encountered parsing data: \(error)")
        }
        
      }
      
    }.resume()
    
  }
}
