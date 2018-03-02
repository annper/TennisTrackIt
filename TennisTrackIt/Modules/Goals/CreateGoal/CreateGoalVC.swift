//
//  CreateGoalVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var descTextView: UITextView!
  
  // MARK: - IBActions
  
  @IBAction func didTapDoneBarButtonItem(_ sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
    
    dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    Logger.info("CreateGoalVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  
}
