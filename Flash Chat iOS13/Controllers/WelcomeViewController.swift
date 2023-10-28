//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Geet Gobind Singh on 21/10/2019.
//  Copyright © 2019 Geet Gobind Singh. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
//    var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.appName
        title = "Welcome"
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        let title = titleLabel.text!
//        let charCount: Double = Double(title.count + 1)
//
//        timer = Timer.scheduledTimer(withTimeInterval: 0.2 * charCount, repeats: true) { Timer in
//            self.beginAnimation(title)
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        timer?.invalidate()
//    }
//
//    func beginAnimation(_ title: String) {
//        self.titleLabel.text = ""
//        var charIndex = 0.0
//        for letter in title {
//            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { Timer in
//                self.titleLabel.text?.append(letter)
//            }
//            charIndex+=1
//        }
//    }
    

}
