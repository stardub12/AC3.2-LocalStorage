//
//  BlockGroundAPIManager.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

struct BlockGroundConstant {
  static let notSet = "Not Set"
  static let baseURL = "https://api.fieldbook.com/v1/"
  static let imageEndPoint = "/images"
}

// add in download delegation
internal class BlockGroundAPIManager: NSObject {
  private var bookId: String
  private var baseURL: String
  private var session: URLSession! = URLSession.shared
  
  static let shared: BlockGroundAPIManager = BlockGroundAPIManager()
  private override init() {
    bookId = BlockGroundConstant.notSet
    baseURL = BlockGroundConstant.baseURL
  }
  
  internal func configure(bookId: String, baseURL: String = BlockGroundConstant.baseURL) {
    self.bookId = bookId
    self.baseURL = baseURL
//    self.session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
  }
  
  internal func requestAllBlockGrounds(completion: @escaping ([BlockGround]?, Error?)->Void) {
    
    // define URL from base + bookId + endpoint
    let url = URL(string: "")!
    
    // create data task
    session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      
      // check for errors
      
      // check for data
      
      // parse model objects

      // implement completions
    }.resume()
    
  }
  
  internal func downloadBlockGround(_ blockground: BlockGround, completion: @escaping (UIImage?)->Void) {
    // define url from blockground model

    // create download task for session.. with or without handler?
    
    // give task a description
    
    // start task
  }
  
  // MARK: - Download Delegate 
//  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    // check for finished download
//  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    // keep track of periodic downloads
    
    // check for % completed and print
    
    // what do we do when the nsurl session transfer size is unknown?
    // lets display some info at least (MB)
  }

}
