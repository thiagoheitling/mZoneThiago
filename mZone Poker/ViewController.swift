//
//  ViewController.swift
//  mZone Poker
//
//  Created by Satraj Bambra on 2015-08-16.
//  Copyright © 2015 BHouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
  
  @IBOutlet weak var chipCountTextfield: UITextField!
  @IBOutlet weak var bigBlindTextfield: UITextField!
  @IBOutlet weak var chipCountLabel: UILabel!
  @IBOutlet weak var bigBlindLabel: UILabel!
  @IBOutlet weak var recommendationButton: UIButton!
  @IBOutlet weak var holderView: UIView!
  @IBOutlet weak var titleImageLayoutContstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setLabels()
    setRoundedCorners()
    chipCountTextfield.becomeFirstResponder()
  }
  
  func setLabels() {
    chipCountLabel.text = NSLocalizedString("CHIP COUNT", comment: "")
    bigBlindLabel.text = NSLocalizedString("BIG BLIND", comment: "")
    recommendationButton.setTitle(NSLocalizedString("WHAT SHOULD I DO?", comment: ""), forState: .Normal)
  }
  
  func setRoundedCorners() {
    recommendationButton.layer.cornerRadius = 3.0;
    holderView.layer.cornerRadius = 3.0;
  }
  
  @IBAction func displayRecommendedAction(sender: UIButton) {

    if (chipCountTextfield.text!.characters.count == 0) {
      displayMessage(NSLocalizedString("Please enter your chip count", comment: ""),
        title: NSLocalizedString("Action Required", comment: ""));
      return;
    }
    if (bigBlindTextfield.text!.characters.count == 0) {
      displayMessage(NSLocalizedString("Please enter the big blind amount", comment: ""),
        title: NSLocalizedString("Action Required", comment: ""));
      return;
    }
    
    guard let chipCountValue = Int(chipCountTextfield.text!) else { return }
    guard let bigBlindValue = Int(bigBlindTextfield.text!) else { return }
    let totalBlindValue = bigBlindValue + (bigBlindValue / 2)
    let mValue = chipCountValue / totalBlindValue
    
    if (mValue > 6) {
      displayMessage(NSLocalizedString("You can wait for better cards", comment: ""),
        title: NSLocalizedString("Recommendation", comment: ""))
    } else {
      displayMessage(NSLocalizedString("Go all in", comment: ""),
        title: NSLocalizedString("Recommendation", comment: ""))
    }
    for textField in (holderView.subviews.filter {$0 is UITextField}) as! [UITextField] {
      textField.text = nil
    }
  }
  
  func displayMessage(message: NSString, title: NSString) {
    let alertController = UIAlertController(title: title as String, message: message as String, preferredStyle: .Alert)
    let cancelAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Cancel) { (action) in }
    alertController.addAction(cancelAction)
    self.presentViewController(alertController, animated: true, completion: nil)
  }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(textField: UITextField) {
    if (view.frame.size.height == 480.0) {
      if (textField == bigBlindTextfield) {
        animateLayoutConstraintToSize(0.0)
      }
    }
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    if (view.frame.size.height == 480.0) {
      if (textField == bigBlindTextfield) {
        animateLayoutConstraintToSize(78.0)
      }
    }
  }
  
  func animateLayoutConstraintToSize(size: CGFloat) {
    view.layoutIfNeeded()
    UIView.animateWithDuration(0.3,
      animations: {
        self.titleImageLayoutContstraint.constant = size
        self.view.layoutIfNeeded()
      }
    )
  }
}

