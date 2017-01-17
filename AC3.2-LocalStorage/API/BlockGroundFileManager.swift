//
//  BlockGroundFileManager.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

internal class BlockGroundFileManager {
  private let manager: FileManager = FileManager()
  private let folderName: String = "BlockGrounds"
  private var rootURL: URL!
  private var imagesURL: URL!
  
  internal static let shared: BlockGroundFileManager = BlockGroundFileManager()
  private init() {
    do {
      // define a rootURL
      rootURL = try manager.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
      
      // create & define a Blockground Images URL
      imagesURL = URL(string: folderName, relativeTo: rootURL)
      try manager.createDirectory(at: imagesURL, withIntermediateDirectories: true, attributes: nil)
    }
    catch {
      print("Error attempting to locate local directory: \(error)")
    }
  }
  
  // TODO: locate URL, create if necessary
  internal func rootDir() -> URL {
    return self.rootURL
  }
  
  internal func blockgroundsDir() -> URL {
    return self.imagesURL
  }
  
  // TODO: list contents of URL
  internal func listContentsOfBlockgroundsDir() -> [URL]? {
    do {
      return try manager.contentsOfDirectory(at: rootDir(), includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    }
    catch {
      print("Error encountered listing contents of url: \(rootURL.lastPathComponent), \(error)")
      return nil
    }
  }
  
  // TODO: Contents should be just images
}
