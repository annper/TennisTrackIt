//
//  SkillDetailVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 12/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class SkillDetailVC: UIViewController {
  
  // MARK: - Private properties
  private var inEditMode: Bool = false
  private let skillDataManager = SkillDataManager()
  private var assignedCategory: SkillCategory = .other
  
  // MARK: - Public properties
  
  public var skill: Skill!
  
  // MARK: - IBOutlets
  
  @IBOutlet var categoryLabel: UILabel! { didSet {
    categoryLabel.text = skill.category.rawValue
    assignedCategory = skill.category
  }}
  
  @IBOutlet var pickerView: UIPickerView! { didSet {
    pickerView.delegate = self
    pickerView.dataSource = self
  }}
  
  @IBOutlet var selectCategoryViewHeightConstraint: NSLayoutConstraint! { didSet {
    selectCategoryViewHeightConstraint.constant = 0
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapEditBarButtonItem(_ sender: UIBarButtonItem) {
    Logger.info("didTapEditBarButtonItem")
    
    animateToggleShowPickerView(show: !inEditMode)
    configRightBarButtonItem()
    
    inEditMode = !inEditMode
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = skill.title
    Logger.info("SkillDetailVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  // MARK: - Private methods
  
  private func configRightBarButtonItem() {
    let shouldEnterEditMode = !inEditMode
    
    if shouldEnterEditMode {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapEditBarButtonItem(_:)))
      
    } else {
      navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditBarButtonItem(_:)))
      
      // Save the skill with the new category
      skill.category = assignedCategory
      _ = skillDataManager.update(skill)
    }
    
  }
  
  private func animateToggleShowPickerView(show shouldShow: Bool) {
    
    let pickerViewHeight: CGFloat = shouldShow ? 150 : 0
    
    selectCategoryViewHeightConstraint.constant = pickerViewHeight
    
    UIView.animate(withDuration: 0.5, animations: {
      self.view.layoutIfNeeded()
    })
    
  }
}

extension SkillDetailVC: UIPickerViewDataSource, UIPickerViewDelegate {
  
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
