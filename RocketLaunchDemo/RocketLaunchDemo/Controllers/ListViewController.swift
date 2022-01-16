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
        
        theTableView.registerCell(identifier: identifierL)
        theTableView.dataSource = self
        theTableView.delegate = self
        
        getRocketLaunches()
    }

}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        launchCell = theTableView.dequeueReusableCell(withIdentifier: identifierL, for: indexPath) as? LaunchTableViewCell
        
        let launch = launchResponse[indexPath.row]
        
        launchCell?.downloadImage(imageKey: launch.links?.mission_patch_small ?? "")
        
        launchCell?.titleLabel.text = launch.mission_name
        launchCell?.descriptionLabel.text = (launch.details ?? "")
        
        let launchDate = launch.launch_date_utc?.toDate()
        let formattedLaunchDate = launchDate?.toString(formatType: "dd-MM-yyyy")
        launchCell?.dateLabel.text = formattedLaunchDate
        
        return launchCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let launchDetailVC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "LaunchDetailVC") as? LaunchDetailViewController {
            launchDetailVC.selectedLaunch = launchResponse[indexPath.row]
            navigationController?.pushViewController(launchDetailVC, animated: true)
        }
    }
}

extension ListViewController {
    
    func getRocketLaunches() {
        ServiceManager.connected.getRocketLaunches(parameters: nil) { (response, isOK) in
            if isOK {
                self.launchResponse = response ?? []
                
                self.theTableView.reloadData()
            }
        }
    }
}
