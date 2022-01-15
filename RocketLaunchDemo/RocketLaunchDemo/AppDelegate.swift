//
// AppDelegate.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

let appMode = "test" // test or live
let appDelegate = UIApplication.shared.delegate as! AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var theStoryboard:UIStoryboard!
    var rootVC:RootViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        theStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        openRoot()
        
        return true
    }

    func openRoot() {
        self.rootVC = self.theStoryboard.instantiateViewController(withIdentifier: "RootVC") as? RootViewController
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.rootVC
        self.window?.makeKeyAndVisible()
    }
}

