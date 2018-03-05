//
//  CreateGoalVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
  
  // MARK: - Private properties
  
  let goalDataManager = GoalDataManager()
  
  // MARK: - IBOutlets
  
  @IBOutlet var cancelBarButtonItem: UIBarButtonItem!
  @IBOutlet var doneBarButtonItem: UIBarButtonItem!
  
  @IBOutlet var titleTextField: UITextField! { didSet {
    titleTextField.delegate = self
    titleTextField.layer.cornerRadius = 5
  }}
  
  @IBOutlet var descTextView: UITextView! { didSet {
    descTextView.delegate = self
    descTextView.layer.cornerRadius = 5
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapDoneBarButtonItem(_ sender: UIBarButtonItem) {
    
    // Save goal
    let goal = createGoal()
    goalDataManager.add(goal)
    
    Logger.info("Goal saved with id: \(goal.id)")
    
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
  
  // MARK: - Private methods
  
  /// Create goal from users filled in information
  private func createGoal() -> Goal {
    let goal = Goal()
    
    goal.title = titleTextField.text ?? ""
    goal.description = descTextView.text ?? ""
    
    return goal
  }
  
  // MARK: - UITextFieldDelegate
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    var currentText = textField.text ?? ""
    if string.isEmpty {
      currentText = currentText.performBackspace()
    } else {
      currentText = "\(currentText)\(string)"
    }
    
    doneBarButtonItem.isEnabled = !currentText.isEmpty
    
    return true
    
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    doneBarButtonItem.isEnabled = false
    return true
  }
  
  // MARK: - UITextViewDelegate
  
}
