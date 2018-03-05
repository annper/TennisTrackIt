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
    
    // Sort goals to show newest goal at the top
    let sortedGoals = savedGoals.goals.sorted { $0.id > $1.id }
    allGoals = sortedGoals
  }
  
  private func removeGoal(_ goal: Goal, atIndexPath indexPath: IndexPath) {
    goalDataManager.delete(goal)
    loadSavedGoals()
    collectionView?.deleteItems(at: [indexPath])
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
      
      // TODO: - Prepare data
    case SegueIdentifier.addGoal:
      break;
//      guard let
      
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
