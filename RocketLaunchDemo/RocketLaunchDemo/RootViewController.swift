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
    
    private var activeNC:UINavigationController?
    
    private var activityView:ActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.changeSafeAreaColour(topSAColour: UIColor.lightGray, bottomSAColour: UIColor.clear)
        }
        
        if let ListNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "ListNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(ListNC.view!)
            
            activeNC = ListNC
            
            activeNC?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    public func changeSafeAreaColour(topSAColour:UIColor? = nil, bottomSAColour:UIColor? = nil) {
        if let colour = topSAColour {
            topSafeArea.backgroundColor = colour
        }
        if let colour = bottomSAColour {
            bottomSafeArea.backgroundColor = colour
        }
    }
    
    public func setActivityIndicator(isOn:Bool, message:String? = nil) {
        DispatchQueue.main.async { [self] in
            if isOn {
                activityView = ActivityView(frame: self.view.frame, message: message)
                view.addSubview(activityView!)
            }
            else {
                if activityView != nil && activityView?.activity != nil {
                    activityView?.activity.stopAnimating()
                    activityView?.removeFromSuperview()
                }
            }
        }
    }
}

extension RootViewController: UIGestureRecognizerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        activeNC?.interactivePopGestureRecognizer?.isEnabled = true
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
