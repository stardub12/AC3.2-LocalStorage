//
//  BlockGroundFileManager.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

internal class BlockGroundFileManager {
  // private!
  
  // needs: instance of FilemManager... maybe a default?
  //        folder name
  //        rootURL
  //        imagesURL
  
  // singleton
  internal static let shared: BlockGroundFileManager = BlockGroundFileManager()
  private init() {
      // define a rootURL using url(for:in:appropriateFor:create:true)
      // check that we can actually found it, but how?

      // create & define a Blockground Images URL relative to the root
      
      // ok, now try to create the new folder dir with createDirectory(at:withIntermediateDirectories:attributes:)
  }
  
//  internal func rootDir() -> URL {
//  }
  
//  internal func blockgroundsDir() -> URL {
//  }
  
  // list contents of the blockgrounds dir
  internal func listContentsOfBlockgroundsDir() -> [URL]? {
      // get the contents using cotentsOfDirectory(at:includingPropertiesForKeys:, options:)
    return nil 
  }
  
}
