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
  
  private let reuseIdentifier = "GoalCell"
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register cell classes
//    self.collectionView!.register(GoalsCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    Logger.info("Goals tab")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

    Logger.warn("didReceiveMemoryWarning")
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
  
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
    cell.setupCell()
    
    return cell
  }
  
  // MARK: UICollectionViewDelegate
  
}
