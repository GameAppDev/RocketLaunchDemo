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
    
    private var activity:XActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.setupViews()
        }
        
        if let ListNC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "ListNC") as? UINavigationController {
            activeNC?.view.removeFromSuperview()
            activeView.addSubview(ListNC.view!)
            
            activeNC = ListNC
            
            activeNC?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    private func setupViews() {
        topSafeArea.backgroundColor = UIColor.lightGray
        bottomSafeArea.backgroundColor = UIColor.clear
    }
    
    func setActivityIndicator(isOn:Bool) {
        DispatchQueue.main.async { [self] in
            if isOn {
                activity = XActivityView(frame: self.view.frame)
                view.addSubview(activity!)
            }
            else {
                if activity != nil && activity?.theActivity != nil {
                    activity?.theActivity.stopAnimating()
                    activity?.removeFromSuperview()
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
