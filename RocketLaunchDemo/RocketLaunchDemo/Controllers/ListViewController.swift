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
    private var slideCell:SlideTableViewCell?
    private var launchCell:LaunchTableViewCell?
    
    private var imageCollCell:SlideImageCollectionViewCell?
    
    private var launchResponse:[LaunchResponse] = []
    private var launchUpcomingResponse:[LaunchUpcomingResponse] = []
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        theTableView.registerCell(identifier: SlideTableViewCell().identifier)
        theTableView.registerCell(identifier: LaunchTableViewCell().identifier)
        theTableView.dataSource = self
        theTableView.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Almost...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        theTableView.addSubview(refreshControl)
        
        getRocketLaunches()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getRocketLaunches()
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchResponse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            slideCell = theTableView.dequeueReusableCell(withIdentifier: SlideTableViewCell().identifier, for: indexPath) as? SlideTableViewCell
            
            slideCell?.theCollectionView.register(UINib(nibName: "SlideImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SlideImageCollectionViewCell().identifier)
            slideCell?.theCollectionView.dataSource = self
            slideCell?.theCollectionView.delegate = self
            
            return slideCell!
        }
        else {
            launchCell = theTableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell().identifier, for: indexPath) as? LaunchTableViewCell
            
            let launch = launchResponse[indexPath.row-1]
            
            if let image = launch.links?.mission_patch {
                launchCell?.downloadImage(imageKey: image)
            }
            
            launchCell?.titleLabel.text = launch.mission_name
            if let details = launch.details {
                launchCell?.descriptionLabel.text = details
            }
            
            if let rocketDate = launch.launch_date_utc {
                let launchDate = rocketDate.toDate()
                let formattedLaunchDate = launchDate.toString(formatType: "dd-MM-yyyy")
                launchCell?.dateLabel.text = formattedLaunchDate
            }
            
            return launchCell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            if let launchDetailVC = appDelegate.theStoryboard.instantiateViewController(withIdentifier: "LaunchDetailVC") as? LaunchDetailViewController {
                launchDetailVC.selectedLaunch = launchResponse[indexPath.row-1]
                navigationController?.pushViewController(launchDetailVC, animated: true)
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchUpcomingResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        imageCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideImageCollectionViewCell().identifier, for: indexPath) as? SlideImageCollectionViewCell

        let launchUpcoming = launchUpcomingResponse[indexPath.row]
        
        if let image = launchUpcoming.links?.mission_patch {
            imageCollCell?.downloadImage(imageKey: image)
        }
        imageCollCell?.theLabel.text = launchUpcoming.mission_name
        
        slideCell?.pageControl.numberOfPages = launchUpcomingResponse.count //TableView Item
        slideCell?.pageControl.currentPage = indexPath.row
        
        return imageCollCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(280).ws, height: CGFloat(230).ws)
    }
}

// API Request
extension ListViewController {
    
    private func getRocketLaunches() {
        appDelegate.rootVC.setActivityIndicator(isOn: true, message: "Rocket is going, \nlook at the air!")
        ServiceManager.shared.getRocketLaunches(parameters: nil) { (response, isOK) in
            appDelegate.rootVC.setActivityIndicator(isOn: false)
            if isOK {
                if let rocketResponse = response {
                    self.launchResponse = rocketResponse
                }
                
                DispatchQueue.main.async {
                    self.theTableView.reloadData()
                }
                
                self.getRocketLaunchesUpcoming()
            }
        }
    }
    
    private func getRocketLaunchesUpcoming() {
        appDelegate.rootVC.setActivityIndicator(isOn: true)
        ServiceManager.shared.getRocketLaunchesUpcoming(parameters: nil) { (response, isOK) in
            appDelegate.rootVC.setActivityIndicator(isOn: false)
            if isOK {
                self.refreshControl.endRefreshing()
                self.fillUpcomingResponse(upcomingResponse: response ?? [])
            }
        }
    }
    
    private func fillUpcomingResponse(upcomingResponse:[LaunchUpcomingResponse]) {
        launchUpcomingResponse.removeAll()
        for response in upcomingResponse {
            if response.isReadyToAdvance() {
                launchUpcomingResponse.append(response)
            }
        }
        
        DispatchQueue.main.async {
            self.slideCell?.theCollectionView.reloadData()
        }
    }
}
