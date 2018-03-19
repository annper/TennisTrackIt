//
//  DrillsVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 19/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class DrillsVC: UIViewController {
  
  // MARK: - Private properties
  private var cellReuseidentifier: String = "DrillCell"
  var activeSortType: SortType = .alphabetic
  
  // MARK: - IBOutlets
  
  @IBOutlet var tableView: UITableView! { didSet {
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
  }}
  
  @IBOutlet var searchBar: UISearchBar! { didSet {
   searchBar.delegate = self
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapSettingsBarButtonItem(_ sender: UIBarButtonItem) {
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.hideShadow()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Logger.info("Drills tab")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  // MARK: - Private methods
  
  private func showSettingsAlert() {
    
    let alert = UIAlertController(title: "Settings", message: "Choose the action you wish to perform", preferredStyle: .actionSheet)
    
    // Delete
    let delete = UIAlertAction(title: "Delete drills", style: .destructive) { (_) in
      Logger.info("Entere delete mode")
    }
    alert.addAction(delete)
    
    // Ordering
    let ordering = UIAlertAction(title: "Set display order", style: .default) { (_) in
      self.showOrderSettings()
    }
    alert.addAction(ordering)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  private func showOrderSettings() {
    
    let alert = UIAlertController(title: "Order drills", message: "Set the order in which you wish the skills to be displayed", preferredStyle: .actionSheet)
    
    // alphabetically
    let alphabetic = UIAlertAction(title: activeSortType.sortDescriptor(.alphabetic), style: .default) { (_) in
      Logger.info("Sort alphabetically")
    }
    alert.addAction(alphabetic)
    
    present(alert, animated: true, completion: nil)
  }
}

extension DrillsVC: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseidentifier, for: indexPath)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Header"
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
  }
  
  // MARK: - UITableViewDelegate
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    
    guard let header = view as? UITableViewHeaderFooterView else {
      return
    }
    
    header.textLabel?.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
    header.textLabel?.font = UIFont(name: "HelveticaNeue-Regular", size: 16.0)
    
  }
  
}

extension DrillsVC: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
    // filter _ reload data
//    tableView.reloadData()
    
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
  
}
