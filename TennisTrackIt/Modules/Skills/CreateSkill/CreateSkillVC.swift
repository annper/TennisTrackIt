//
//  CreateSkillVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 12/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class CreateSkillVC: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet var doneBarButtonItem: UIBarButtonItem!
  
  // MARK: - IBActions
  
  @IBAction func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapDoneBarButtonItem(_ sender: UIBarButtonItem) {
    
    Logger.info("didTapDoneBarButtonItem")
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("CreateSkillVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
}
