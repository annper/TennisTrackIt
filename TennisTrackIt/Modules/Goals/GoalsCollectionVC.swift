//
//  GoalsCollectionVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 01/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class GoalsCollectionVC: UICollectionViewController {
  
  // MARK: - Private properties
  
  private let goalDataManager = GoalDataManager()
  
  private struct SegueIdentifier {
    static let goalDetail = "GoalDetailSegue"
    static let addGoal = "CreateGoalSegue"
  }
  
  private let reuseIdentifier = "GoalCell"
  private var allGoals = [Goal]()
  
  // MARK: - IBOutlets
  
  @IBOutlet var settingsBarButtonItem: UIBarButtonItem! { didSet {
    settingsBarButtonItem.tintColor = UIColor.black
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapSettingsBarButtonItem(_ sender: UIBarButtonItem) {
    let alert = UIAlertController(title: "Order goals", message: "Set the order in which you wish the goals to be displayed", preferredStyle: .actionSheet)
    
    // Sort alphabetically
    let alphabetic = UIAlertAction(title: "Alphabetically", style: .default) { (_) in
      self.updateSortSetting(to: .alphabetic)
    }
    alert.addAction(alphabetic)
    
    // Sort with last created at the top
    let createdDate = UIAlertAction(title: "In order of creation date", style: .default) { (_) in
      self.updateSortSetting(to: .createdDate)
    }
    alert.addAction(createdDate)
    
    // Cancel
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadSavedGoals()
    
    setupCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    refreshGoalList()
    
    Logger.info("Goals tab")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

    Logger.warn("didReceiveMemoryWarning")
  }
  
  // MARK: - Private methods
  
  private func setupCollectionView() {
    
    // Register nib for custom cell
    collectionView?.register(UINib.init(nibName: "GoalsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    
    // Set estimated size to enable dynamic cell size
    if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
    }
  }
  
  private func loadSavedGoals() {
    
    guard let savedGoals = goalDataManager.savedGoals() else {
      return
    }

    let sorted = savedGoals.sortedGoals()
    allGoals = sorted
  }
  
  private func updateSortSetting(to sortType: SortType) {
    goalDataManager.updateSortSetting(to: sortType)
    refreshGoalList()
  }
  
  private func showDeleteGoalAlert(forGoal goal: Goal, completeDeletion: ((UIAlertAction) -> Void)?) {
    
    let alert = UIAlertController(title: "Delete \(goal.title)", message: "Are you sure you wish to delete this goal?", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: completeDeletion)
    alert.addAction(okAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  private func removeGoal(_ goal: Goal, atIndexPath indexPath: IndexPath) {
    showDeleteGoalAlert(forGoal: goal) { (_) in
      self.goalDataManager.delete(goal)
      self.loadSavedGoals()
      self.collectionView?.deleteItems(at: [indexPath])
    }
  }
  
  private func refreshGoalList() {
    loadSavedGoals()
    collectionView?.reloadData()
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let segueIdentifier = segue.identifier ?? ""
    Logger.info("Performing segue with identifier: \(segueIdentifier)")
    
    switch segueIdentifier {
      
    // Prepare to show GoalDetailVC
    case SegueIdentifier.goalDetail:
      
      guard let goalDetailVC = segue.destination as? GoalDetailVC else {
        Logger.warn("GoalDetailVC could not be loaded from segue")
        return
      }
    
      if let indexPath = collectionView?.indexPathForSelectedItem {
        goalDetailVC.goal = allGoals[indexPath.row]
      }
    default:
      return
    }
    
  }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return allGoals.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GoalsCollectionViewCell else {
      
      Logger.warn("Failed to load GoalsCollectionViewCell")
      
      return UICollectionViewCell()
    }
    
    // Configure the cell
    let goal = allGoals[indexPath.row]
    let goalCellItem = GoalCellItem(indexPath: indexPath, goal: goal, removeGoalAction: removeGoal(_:atIndexPath:))
    cell.setupCell(withCellItem: goalCellItem)
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    Logger.info("Item at indexPath \(indexPath) was selected")
    
    performSegue(withIdentifier: SegueIdentifier.goalDetail, sender: self)
    
  }
  
}
