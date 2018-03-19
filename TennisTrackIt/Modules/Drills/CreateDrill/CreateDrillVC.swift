//
//  CreateDrillVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 19/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class CreateDrillVC: UIViewController {

  // MARK - Private properties
  
  let drillDataManager = DrillDataManager()
  
  // MARK: - IBActions
  
  @IBAction func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("CreateDrillVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }

}
