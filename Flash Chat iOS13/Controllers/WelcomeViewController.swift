//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        let titleText = "⚡️FlashChat"
        let titleTemp = ""
        titleLabel.text = titleTemp
        var charIndex = 0.0
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false, block: {(Timer) in
                self.titleLabel.text?.append(letter)
            })
            print(letter)
            charIndex+=1
        }
    }
    

}
