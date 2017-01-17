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
    
    self.directoryItems = BlockGroundFileManager.shared.listContentsOfBlockgroundsDir()

    BlockGroundAPIManager.shared.configure(bookId: "587d55d093e81a0400aef3b2")
    BlockGroundAPIManager.shared.requestAllBlockGrounds { (blockground: [BlockGround]?, error: Error?) in
      
      if blockground != nil {
        for block in blockground! {
          BlockGroundAPIManager.shared.downloadBlockGround(block, completion: { (image: UIImage?) in
            
          })
        }
      }
      
    }
  }
  
  
  // MARK: - Setup
  private func configureConstraints() {
    self.edgesForExtendedLayout = []
    
    self.previewView.snp.makeConstraints { (make) in
      make.top.leading.trailing.equalToSuperview()
      make.height.equalTo(self.view).multipliedBy(0.25)
    }
    
    self.localFilesTable.snp.makeConstraints { (make) in
      make.top.equalTo(self.previewView.snp.bottom)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func setupViewHierarchy() {
    self.view.addSubview(previewView)
    self.view.addSubview(localFilesTable)
    
    self.localFilesTable.delegate = self
    self.localFilesTable.dataSource = self
    self.localFilesTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
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
