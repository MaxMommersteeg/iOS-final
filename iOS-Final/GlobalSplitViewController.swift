//
//  GlobalSplitViewController.swift
//  iOS-Final
//
//  Created by M Mommersteeg on 08/04/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit

class GlobalSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool{
        return true
    }
}
