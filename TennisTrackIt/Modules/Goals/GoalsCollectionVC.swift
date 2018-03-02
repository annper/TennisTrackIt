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
  
  private struct SegueIdentifier {
    static let goalDetail = "GoalDetailSegue"
    static let addGoal = "CreateGoalSegue"
  }
  
  private let reuseIdentifier = "GoalCell"
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
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
  
  private func getIndexPathForSelectedCell() -> IndexPath? {
    
    guard let selectedItems = collectionView?.indexPathsForSelectedItems, let indexPath = selectedItems.first else {
      Logger.warn("No selected items found")
      return nil
    }
    
    return indexPath
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
    return 2
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? GoalsCollectionViewCell else {
      
      Logger.warn("Failed to load GoalsCollectionViewCell")
      
      return UICollectionViewCell()
    }
    
    // Configure the cell
    cell.setupCell(withText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    Logger.info("Item at indexPath \(indexPath) was selected")
    
    performSegue(withIdentifier: SegueIdentifier.goalDetail, sender: self)
    
  }
  
}
