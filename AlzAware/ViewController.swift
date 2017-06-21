//
//  ViewController.swift
//  AlzAware
//
//  Copyright © 2017 Silversphere. All rights reserved.
//

import UIKit
import CircleProgressBar

class ViewController: UIViewController {

    @IBOutlet var sixtySecondCounter: CircleProgressBar!
    @IBOutlet var diagnosedTodayCounter: UILabel!
    @IBOutlet var brain: UIImageView!
    @IBOutlet var brainTopSpacingConstraint: NSLayoutConstraint!
    @IBOutlet var alzheimersPatient1: UIImageView!
    @IBOutlet var alzheimersPatient2: UIImageView!
    @IBOutlet var alzheimersPatient3: UIImageView!
    @IBOutlet var alzheimersPatient4: UIImageView!
    @IBOutlet var alzheimersPatient5: UIImageView!
    @IBOutlet var alzheimersPatient6: UIImageView!
    
    private var diagnoseTimer: Timer?
    private var patientTimer: Timer?
    var count = 0;
    var diagnosedToday = 0;
    var currentHighlightedPerson = 1;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.diagnoseTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateDiagnoseTimer), userInfo: nil, repeats: true);
        self.patientTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.updateAlzheimerPatientColor), userInfo: nil, repeats: true);
        
        self.sixtySecondCounter.setHintTextGenerationBlock { (progress) -> String? in
            return String.init(format: "%1.0f", arguments: [progress * 66])
        }
        
        setImageTint()
        
        let date = Date()
        let cal = Calendar(identifier: .gregorian)
        let midnight = cal.startOfDay(for: date)
        let intervalSinceDate = Date().timeIntervalSince(midnight)
        diagnosedToday = Int(intervalSinceDate) / 66
        diagnosedTodayCounter.text = String(diagnosedToday)
        
    }
    
    private func setImageTint() {
        alzheimersPatient1.image = alzheimersPatient1.image?.withRenderingMode(.alwaysTemplate)
        alzheimersPatient2.image = alzheimersPatient2.image?.withRenderingMode(.alwaysTemplate)
        alzheimersPatient3.image = alzheimersPatient3.image?.withRenderingMode(.alwaysTemplate)
        alzheimersPatient4.image = alzheimersPatient4.image?.withRenderingMode(.alwaysTemplate)
        alzheimersPatient5.image = alzheimersPatient5.image?.withRenderingMode(.alwaysTemplate)
        alzheimersPatient6.image = alzheimersPatient6.image?.withRenderingMode(.alwaysTemplate)
        brain.image = brain.image?.withRenderingMode(.alwaysTemplate)
        
        alzheimersPatient1.tintColor = UIColor.white
        alzheimersPatient2.tintColor = UIColor.white
        alzheimersPatient3.tintColor = UIColor.white
        alzheimersPatient4.tintColor = Constants.secondaryColor
        alzheimersPatient5.tintColor = Constants.secondaryColor
        alzheimersPatient6.tintColor = UIColor.white
        brain.tintColor = UIColor.white
    }
    
    @objc func updateDiagnoseTimer() {
        if count < 66 {
            count += 1;
        } else {
            count = 0;
            diagnosedToday += 1;
            UIView.animate(withDuration: 1.5, animations: {
                self.brainTopSpacingConstraint.constant = 200
                self.view.layoutIfNeeded()
            }, completion:{ _ in
                self.brainTopSpacingConstraint.constant = -75
                self.diagnosedTodayCounter.text = String(self.diagnosedToday)
            })
        }
        self.sixtySecondCounter.setProgress(CGFloat(count) / 66.0, animated: true);
    }
    
     @objc func updateAlzheimerPatientColor() {
        if currentHighlightedPerson < 3 {
            currentHighlightedPerson += 1
        } else {
            currentHighlightedPerson = 1;
        }
        
        //Reset all three back to white.
        UIView.animate(withDuration: 0.5, animations: {
            self.alzheimersPatient1.tintColor = UIColor.white
            self.alzheimersPatient2.tintColor = UIColor.white
            self.alzheimersPatient3.tintColor = UIColor.white
        }, completion:{ _ in
            
            if self.currentHighlightedPerson == 1 {
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.alzheimersPatient1.tintColor = Constants.secondaryColor
                })
            }
            if self.currentHighlightedPerson == 2 {
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.alzheimersPatient2.tintColor = Constants.secondaryColor
                })
            }
            if self.currentHighlightedPerson == 3 {
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.alzheimersPatient3.tintColor = Constants.secondaryColor
                })
            }
        
        })
    }
}

