//
//  LocalFilesViewController.swift
//  AC3.2-LocalStorage
//
//  Created by Louis Tur on 1/16/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class LocalFilesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  private let cellIdentifier: String = "LocalFileCellIdentifier"
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewHierarchy()
    configureConstraints()
    
    BlockGroundAPIManager.shared.configure(bookId: "587d55d093e81a0400aef3b2")
    BlockGroundAPIManager.shared.requestAllBlockGrounds { (blockground: [BlockGround]?, error: Error?) in
      
    }
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.edgesForExtendedLayout = []
    stripMaskResizing(previewView, localFilesTable)
    
    
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(previewView)
    self.view.addSubview(localFilesTable)
    
    self.localFilesTable.delegate = self
    self.localFilesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
  
  
  // MARK: - TableView Delegates
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    return cell
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
