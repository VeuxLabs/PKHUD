//
//  DemoViewController.swift
//  PKHUD Demo
//
//  Created by Philip Kluz on 6/18/14.
//  Copyright (c) 2016 NSExceptional. All rights reserved.
//

import UIKit
import PKHUD

class DemoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.dimsBackground = false
        HUD.allowsInteraction = false
    }

    @IBAction func showAnimatedSuccessHUD(sender: AnyObject) {
        HUD.flash(.success, delay: 2.0)
    }
    
    @IBAction func showAnimatedErrorHUD(sender: AnyObject) {
        HUD.show(.error)
        HUD.hide(afterDelay: 2.0)
    }
    
    @IBAction func showAnimatedProgressHUD(sender: AnyObject) {
        HUD.show(.progress)
        
        // Now some long running task starts...
        delay(delay: 2.0) {
            // ...and once it finishes we flash the HUD for a second.
            HUD.flash(.success, delay: 1.0)
        }
    }
    
    @IBAction func showCustomProgressHUD(sender: AnyObject) {
        HUD.flash(.rotatingImage(UIImage(named: "progress")), delay: 2.0)
    }
    
    @IBAction func showAnimatedStatusProgressHUD(sender: AnyObject) {
        HUD.flash(.labeledProgress(title: "Title", subtitle: "Subtitle"), delay: 2.0)
    }
    
    @IBAction func showTextHUD(sender: AnyObject) {
        HUD.flash(.label("Requesting Licence…"), delay: 2.0) { _ in
            print("License Obtained.")
        }
    }
    
    /*
    
    Please note that the above demonstrates the "porcelain" interface - a more concise and clean way to work with the HUD.
    If you need more options and flexbility, feel free to use the underlying "plumbing". E.g.:
    
    PKHUD.sharedHUD.show()
    PKHUD.sharedHUD.contentView = PKHUDSuccessView(title: "Success!", subtitle: nil)
    PKHUD.sharedHUD.hide(afterDelay: 2.0)
    */
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func delay(delay:Double, closure:@escaping ()->Void) {
        let delayTime = DispatchTimeInterval.seconds(Int(delay))
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            closure()
        }
    }
}
