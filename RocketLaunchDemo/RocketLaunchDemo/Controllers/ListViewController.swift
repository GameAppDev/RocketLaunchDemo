//
// ListViewController.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class ListViewController: UIViewController {

    @IBOutlet var theTableView: UITableView!
    let identifierL:String = "LaunchTableViewCell"
    var launchCell:LaunchTableViewCell?
    
    var launchResponse:[LaunchResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        getRocketLaunches()
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}

extension ListViewController {
    
    func getRocketLaunches() {
        ServiceManager.connected.getRocketLaunches(parameters: nil) { (response, isOK) in
            if isOK {
                
            }
            else {
                
            }
        }
    }
}
