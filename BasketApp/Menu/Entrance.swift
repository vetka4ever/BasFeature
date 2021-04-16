//
//  Sign.swift
//  BasketApp
//
//  Created by Daniil on 01.04.2021.
//

import UIKit

class Entrance: UIViewController {

    @IBOutlet var logInView: UIView!
    @IBOutlet var signInView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInView.alpha = 1
        signInView.alpha = 0
    }
    @IBAction func segment(_ sender: UISegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            logInView.alpha = 1
            signInView.alpha = 0
        }
        else
        {
            logInView.alpha = 0
            signInView.alpha = 1
        }
    }
    

}
