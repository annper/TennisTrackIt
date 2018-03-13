//
//  SkillsTableVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 08/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class SkillsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  // MARK: - Private properties
  
  private let skillDataManger = SkillDataManager()
  private let cellReuseIdentifier: String = "SkillCell"
  private var categories: [String] = []
  private var allSkills: [[Skill]] = [[]]
  private var searchActive: Bool = false
  private let skillDetailSegueIdentifier: String = "SkillDetailSegue"
  private struct SegueIdentifier {
    static let skillDetail: String = "SkillDetailSegue"
    static let skillCreate: String = "CreateSkillSegue"
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet var tableView: UITableView! { didSet {
    tableView.tableFooterView = UIView()
  }}
  
  @IBOutlet var searchBar: UISearchBar! { didSet {
    searchBar.layer.shadowOpacity = 0
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapSettingBarButtonItem(_ sender: UIBarButtonItem) {
    showSettingsActions()
  }
  
  // MARK: - UITableViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.hideShadow()
    configureRightBarButtonItem()
    
    loadSavedSkills()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    refreshTableView()
    
    Logger.info("Skills tab")
  }
  
  // MARK: - Private methods
  
  private func configureRightBarButtonItem() {
    let isInDeleteMode = tableView.isEditing
    
    if isInDeleteMode {
      let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(stopEditing))
      navigationItem.setRightBarButton(doneButton, animated: true)
    } else {
      let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showCreateSkillVC))
      navigationItem.setRightBarButton(addButton, animated: true)
    }
  }
  
  private func loadSavedSkills() {
    
    guard let savedSkills = skillDataManger.savedSkills() else {
      return
    }
    
    let sectionedSkills = savedSkills.getSectionedSkills()
    categories = sectionedSkills.sections
    allSkills = sectionedSkills.skills
    
  }
  
  private func refreshTableView() {
    loadSavedSkills()
    tableView.reloadData()
  }
  
  private func showSettingsActions() {
    
    let alert = UIAlertController(title: "Settings", message: "Choose the action you wish to perform", preferredStyle: .actionSheet)
    
    // Delete
    let delete = UIAlertAction(title: "Delete skills", style: .destructive) { (_) in
      // TODO: - Enter delete mode a la spotify for multiple deletions
      self.enterDeleteMode()
      Logger.info("Open delete menu")
    }
    alert.addAction(delete)
    
    let order = UIAlertAction(title: "Set display order", style: .default) { (_) in
      self.showOrderSettings()
    }
    alert.addAction(order)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  private func enterDeleteMode() {
    tableView.setEditing(true, animated: true)
    
    configureRightBarButtonItem()
  }
  
  @objc private func stopEditing() {
    tableView.setEditing(false, animated: true)
    
    configureRightBarButtonItem()
  }
  
  @objc private func showCreateSkillVC() {
    performSegue(withIdentifier: SegueIdentifier.skillCreate, sender: self)
  }
  
  private func showOrderSettings() {
    
    // TODO: - Enable setting of order + saving of order
    
    let alert = UIAlertController(title: "Order skills", message: "Set the order in which you wish the skills to be displayed", preferredStyle: .actionSheet)
    
    // alphabetical
    let alphabetical = UIAlertAction(title: "Alphabetically", style: .default) { (_) in
      Logger.info("Order alphabetically")
    }
    alert.addAction(alphabetical)
    
    present(alert, animated: true, completion: nil)
  }
  
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let segueIdentifier = segue.identifier ?? ""
    Logger.info("Performing preparation for segue with identifier: \(segueIdentifier)")
    
    switch segueIdentifier {
    case skillDetailSegueIdentifier:
      guard let skillDetailVC = segue.destination as? SkillDetailVC else {
        Logger.warn("Failed to load SkillDetailVC from segue")
        return
      }
      
      if let indexPath = tableView.indexPathForSelectedRow {
        skillDetailVC.skill = allSkills[indexPath.section][indexPath.row]
      }
      
    default: return
    }
    
    
  }
  
  // MARK: - UISearchBarDelegate - TODO
  
  // MARK: - TableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return categories.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allSkills[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    
    let skill = allSkills[indexPath.section][indexPath.row]
    cell.textLabel?.text = skill.title
    
    return cell
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
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return categories[section]
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    
  }
  
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    return "Delete"
  }
  
}
