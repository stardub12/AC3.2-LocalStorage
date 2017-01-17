//
//  LocalFilesViewController.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LocalFilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  private let cellIdentifier: String = "LocalFileCellIdentifier"
  private var directoryItems: [URL]? 
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
    
    // load directory items
    self.directoryItems = BlockGroundFileManager.shared.listContentsOfBlockgroundsDir()

    // configure api manager
    
    // request blockgrounds
    
    // download blockground images
    BlockGroundAPIManager.shared.configure(bookId: "FILL ME IN")
    BlockGroundAPIManager.shared.requestAllBlockGrounds { (blockground: [BlockGround]?, error: Error?) in
      // download blockground images
    }
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.edgesForExtendedLayout = []
    
    // lay out views
  }
  
  private func setupViewHierarchy() {
    // add views

    // set delegate/datasource
    
    // register tableview
    
  }
  
  
  // MARK: - TableView Delegates
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.directoryItems?.count ?? 0
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    cell.textLabel?.text = self.directoryItems?[indexPath.row].absoluteURL.lastPathComponent
    print("cell.textLabel.text = \(cell.textLabel?.text)")
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  // MARK: - Lazy Inits
  internal lazy var previewView: UIView = {
    let view: UIView = UIView()
    view.backgroundColor = .gray
    return view
  }()
  
  internal lazy var localFilesTable: UITableView = {
    let tableView: UITableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
    return tableView
  }()
}
