//
//  GoalDetailVC.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 02/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//

import UIKit

class GoalDetailVC: UIViewController {
  
  // MARK: - Public properties
  
  public var goal: Goal!
  
  // MARK: - Private properties
  
  private let goalDataManager = GoalDataManager()
  
  private var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "dd-MM-YYYY"
    
    return dateFormatter
  }
  
  // MARK: - IBOutlets
  
  @IBOutlet var progressButton: UIButton! { didSet {
    progressButton.layer.cornerRadius = 2
    progressButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
    progressButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    progressButton.layer.shadowRadius = 2
    progressButton.layer.shadowOpacity = 1
    configProgressButtonDisplay()
  }}
  
  @IBOutlet var descTextView: UITextView! { didSet {
    descTextView.layer.cornerRadius = 5
    descTextView.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    descTextView.text = goal.description
  }}
  
  @IBOutlet var descTextViewHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet var createdLabel: UILabel! { didSet {
    createdLabel.text = "Created: \(dateFormatter.string(from: goal.createdDate))"
  }}
  
  // MARK: - IBActions
  
  @IBAction func didTapProgressButton(_ sender: UIButton) {
    goal.completed = !goal.completed
    goalDataManager.update(goal)
    
    configProgressButtonDisplay()
  }
  
  // MARK: - UIViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set nav bar title
    title = goal.title
    resizeTextView(descTextView)
      
    Logger.info("GoalDetailVC")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    Logger.warn("didReceiveMemoryWarning")
  }
  
  // MARK: - Private methods
  
  private func configProgressButtonDisplay() {
    let titleColor: UIColor
    let backgroundColor: UIColor
    let title: String
    
    if goal.completed {
      titleColor = UIColor.white
      backgroundColor = UIColor(red: 1.000, green: 0.250, blue: 0.200, alpha: 1)
      title = "Completed"
    } else {
      titleColor = UIColor(red: 0.800, green: 1.000, blue: 0.400, alpha: 1)
      backgroundColor = UIColor(red: 0.000, green: 0.502, blue: 0.502, alpha: 1)
      title = "In progress"
    }
    
    progressButton.backgroundColor = backgroundColor
    progressButton.setTitleColor(titleColor, for: .normal)
    progressButton.setTitle(title, for: .normal)
  }
  
  private func resizeTextView(_ textView: UITextView) {
    let newHeight = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
    
    if textView.constraints.contains(descTextViewHeightConstraint) {
      descTextViewHeightConstraint.constant = newHeight
    }
  }
  
//  private func resize(textView: UITextView) {
//
//    if let text = textView.text, text.length > 0 {
//
//      let newHeight = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
//
//      if true == textView.constraints.contains(descTextViewHeightConstraint) {
//        descTextViewHeightConstraint.constant = newHeight > descTextViewHeightConstraint.constant ? newHeight : descTextViewHeightConstraint.constant
//      } else {
//        tagsTextViewHeightConstraint.constant = newHeight >                 tagsTextViewHeightConstraint.constant ? newHeight : tagsTextViewHeightConstraint.constant
//      }
//    }
//
//    view.layoutIfNeeded()
//  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
