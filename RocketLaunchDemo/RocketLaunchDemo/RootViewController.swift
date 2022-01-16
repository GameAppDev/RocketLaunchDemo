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
    
    var activity:XActivityView?
    
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
    
    func stateActivityIndicator(isOn:Bool) {
        if isOn {
            activity = XActivityView(frame: self.view.frame)
            self.view.addSubview(activity!)
        } else {
            if activity != nil && activity?.theActivity != nil {
                activity?.theActivity.stopAnimating()
                activity?.removeFromSuperview()
            }
        }
    }
}
