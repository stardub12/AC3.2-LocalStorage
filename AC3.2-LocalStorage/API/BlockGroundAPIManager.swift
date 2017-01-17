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

internal class BlockGroundAPIManager: NSObject, URLSessionDownloadDelegate {
  private var bookId: String
  private var baseURL: String
  private var session: URLSession!
  
  static let shared: BlockGroundAPIManager = BlockGroundAPIManager()
  private override init() {
//    session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    
    // TODO: Add Exceptions/Errors for values being .notSet
    bookId = BlockGroundConstant.notSet
    baseURL = BlockGroundConstant.baseURL
  }
  
  internal func configure(bookId: String, baseURL: String = BlockGroundConstant.baseURL) {
    self.bookId = bookId
    self.baseURL = baseURL
    self.session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
  }
  
  internal func requestAllBlockGrounds(completion: @escaping ([BlockGround]?, Error?)->Void) {
    
    let url = URL(string: baseURL + bookId + BlockGroundConstant.imageEndPoint)!
    session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
      
      if error != nil {
        print("Error: \(error!)")
        completion(nil, error)
        return
      }
      
      // check data
      if data != nil {
        do {
          
          let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String : AnyHashable]]
          guard let validJSONDict = json else { return }
          
          var allBlockGrounds: [BlockGround] = []
          for blockGround in validJSONDict {
            guard let validBlockGround = BlockGround(json: blockGround) else { continue }
            allBlockGrounds.append(validBlockGround)
          }
          
          // send back some blockgrounds
          completion(allBlockGrounds, nil)
        }
        catch {
          print("Error encountered parsing data: \(error)")
        }
        
      }
    }.resume()
    
  }
  
  internal func downloadBlockGround(_ blockground: BlockGround, completion: @escaping (UIImage?)->Void) {
    let url = URL(string: blockground.imageFullResURL)!
    let downloadTask = session.downloadTask(with: url)
    downloadTask.taskDescription = blockground.title
    downloadTask.resume()
  }
  
  // MARK: - Download Delegate 
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
    // TODO check for finished download
    print("Did finish downloading: \(downloadTask.taskDescription)")
  }
  
  func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
    // TODO: keep track of periodic downloads
    
    if totalBytesExpectedToWrite == NSURLSessionTransferSizeUnknown {
      let downloadProgress = Double(totalBytesWritten) / 1000000.0 // in MBs
      let downloadProgressString = String(format: "Could not determine filesize .... downloading: %0.2fMB", downloadProgress)
      print(downloadProgressString)
      return
    }
    
    let percentageComplete = (Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)) * 100.0
    
    print("Downloading \(downloadTask.taskDescription!) ....... \(percentageComplete)% ")
  }

}
