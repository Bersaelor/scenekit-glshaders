//
//  SettingsTableViewController.swift
//  CustomShaders
//
//  Created by Nathanael Beisiegel on 11/24/14.
//  Copyright (c) 2014 Nathanael Beisiegel. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
  
  var settingData: [SettingItem] = []
  var gameUpdater: (() -> ())? // Optional lambda to update, called on row selection
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return settingData.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShaderSettingCell", for: indexPath)
    
    cell.textLabel!.text = settingData[indexPath.row].title
    if settingData[indexPath.row].selected {
      cell.accessoryType = UITableViewCell.AccessoryType.checkmark
    }
    else {
      cell.accessoryType = UITableViewCell.AccessoryType.none
    }
    
    return cell
  }
  
  // MARK: - Table View Delagate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // Set settings to true, then trigger reload to parent
    for i in 0..<settingData.count {
      settingData[i].selected = (i == indexPath.row)
    }
    
    // Animate down, updating view after settings popover closes
    self.dismiss(animated: true, completion: {
      // Update Game
      
      self.gameUpdater?()
      return
    })
  }

  // MARK: - Status Bar
  
  override var prefersStatusBarHidden : Bool {
    return true
  }
}
