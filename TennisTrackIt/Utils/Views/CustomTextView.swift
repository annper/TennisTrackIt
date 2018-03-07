//
//  CustomTextView.swift
//  TennisTrackIt
//
//  Created by Annie Persson on 07/03/2018.
//  Copyright © 2018 Annie Persson. All rights reserved.
//
// UITextView with placeholder
//  - Use: myTextView: CustomTextView { didSet { myTextView.placeholder = "Placeholder text"  } }
//  - How it works: Placeholder is shown/hidden on call to resignFirstResponder/becomeFirstResponder
//

import UIKit

class CustomTextView: UITextView {
  
  // MARK: - Public properties
  
  public var placeholder: String? { didSet {
    prepareForPlaceholder()
  }}
  
  // MARK: - Private properties
  
  private var isShowingPlaceholder: Bool = false
  
  // MARK: - UITextView
  
  override func resignFirstResponder() -> Bool {
    super.resignFirstResponder()
    
    showPlaceholder()
    return true
  }
  
  override func becomeFirstResponder() -> Bool {
    super.becomeFirstResponder()
    
    hidePlaceholder()
    return true
  }
  
  // MARK: - Private methods
  
  private func showPlaceholder() {
    guard let plh = placeholder, text.isBlank, !isShowingPlaceholder else {
      return
    }
    
    isShowingPlaceholder = true
    text = plh
    textColor = textColor?.withAlphaComponent(0.5)
  }
  
  private func hidePlaceholder() {
    guard isShowingPlaceholder else { return }
    
    isShowingPlaceholder = false
    text = ""
    textColor = textColor?.withAlphaComponent(1)
  }
  
  // Setup pre-conditions to show placeholder after initial setup
  private func prepareForPlaceholder() {
    isShowingPlaceholder = false
    text = ""
    showPlaceholder()
  }
}

