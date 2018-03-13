//
//  CreateSkillVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 12/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class CreateSkillVC: UIViewController {
  
  // MARK: - Private properties
  
  let skillDataManager = SkillDataManager()
  var assignedCategory: SkillCategory = .other
  
  // MARK: - IBOutlets
  
  @IBOutlet var categoryLabel: UILabel! { didSet {
    categoryLabel.text = assignedCategory.rawValue
  }}
  
  @IBOutlet var titleLabel: UILabel! { didSet {
    titleLabel.text = ""
  }}
  
  @IBOutlet var titleTextField: UITextField! { didSet {
    titleTextField.delegate = self
  }}
  
  @IBOutlet var doneBarButtonItem: UIBarButtonItem! { didSet {
      doneBarButtonItem.isEnabled = false
  }}
  
  @IBOutlet var categoryPickerView: UIPickerView! { didSet {
    categoryPickerView.dataSource = self
    categoryPickerView.delegate = self
    
    let defaultValue = Int(SkillCategory.allValues.index(of: assignedCategory.rawValue) ?? 0)
    categoryPickerView.selectRow(defaultValue, inComponent: 0, animated: false)
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapCancelBarButtonItem(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didTapDoneBarButtonItem(_ sender: UIBarButtonItem) {
    createAndSaveSkill()
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
  
  // Close keyboard if tapping outside the textField
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard titleTextField.isFirstResponder else { return }
    titleTextField.resignFirstResponder()
  }
  
  // MARK: - Private methods
  
  private func createAndSaveSkill() {
    
    // Create the new skill
    let skill = Skill()
    skill.title = (titleLabel.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
    skill.category = assignedCategory
    
    // Save the skill
    let success = skillDataManager.add(skill)
    
    if success {
      dismiss(animated: true, completion: nil)
    } else {
      showTitleWarningAlert()
    }

  }
  
  private func showTitleWarningAlert() {
    let alert = UIAlertController(title: "Title must be unique", message: "A skill named \"\(titleLabel.text ?? "")\" already exists. Please change it and try again.", preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
      
      // Focus on the text field and open the keyboard
      self.titleTextField.becomeFirstResponder()
    }
    alert.addAction(ok)
    
    present(alert, animated: true, completion: nil)
  }
  
}

// MARK: - UITextFieldDelegate

extension CreateSkillVC: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let currentText = (textField.text ?? "") as NSString
    
    let transformedString: String
    if string.isEmpty {
      transformedString = currentText.replacingCharacters(in: range, with: "")
    } else {
      transformedString = currentText.replacingCharacters(in: range, with: string)
    }
    
    titleLabel.text = transformedString
    doneBarButtonItem.isEnabled = !transformedString.isEmpty
    
    return true
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    titleLabel.text = ""
    doneBarButtonItem.isEnabled = false
    return true
  }
  
  // Handle the keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}

// MARK: - UIPicketViewDataSource + Delegate

extension CreateSkillVC: UIPickerViewDataSource, UIPickerViewDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return SkillCategory.allValues.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return SkillCategory.allValues[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    updateSkillCategory(withRawValue: SkillCategory.allValues[row])
  }
  
  private func updateSkillCategory(withRawValue text: String) {
    categoryLabel.text = text
    assignedCategory = SkillCategory(rawValue: text) ?? .other
  }
  
}
