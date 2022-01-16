//
// RootViewController.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class RootViewController: UIViewController {

    @IBOutlet var topSafeArea: UIView!
    @IBOutlet var bottomSafeArea: UIView!
    @IBOutlet var activeView: UIView!
    
    var activeNC:UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        if let ListNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "ListNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(ListNC.view!)
            
            activeNC = ListNC
        }
    }

}
