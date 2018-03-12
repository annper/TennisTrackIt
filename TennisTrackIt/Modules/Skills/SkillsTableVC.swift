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
  
  // MARK: - IBOutlets
  
  @IBOutlet var tableView: UITableView! { didSet {
    tableView.tableFooterView = UIView()
  }}
  
  @IBOutlet var searchBar: UISearchBar! { didSet {
    searchBar.layer.shadowOpacity = 0
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapSettingBarButtonItem(_ sender: UIBarButtonItem) {
    Logger.info("didTapSettingBarButtonItem")
  }
  
  @IBAction func didTapCreateBarButtonItem(_ sender: UIBarButtonItem) {
    Logger.info("didTapCreateBarButtonItem")
  }
  
  // MARK: - UITableViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.hideShadow()
    
    loadSavedSkills()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Logger.info("Skills tab")
  }
  
  // MARK: - Private methods
  
  private func loadSavedSkills() {
    
    guard let savedSkills = skillDataManger.savedSkills() else {
      return
    }
    
    let sectionedSkills = savedSkills.getSectionedSkills()
    categories = sectionedSkills.sections
    allSkills = sectionedSkills.skills
    
  }
  
  func removeDuplictes(_  array: [String]) -> [String] {
    return array.reduce([]) { (result, category) -> [String] in
      return result.contains(category) ? result : result + [category]
    }
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
  
}
