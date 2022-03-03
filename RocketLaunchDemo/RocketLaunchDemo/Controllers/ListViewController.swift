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
import SwiftUI

class ListViewController: UIViewController {

    @IBOutlet var theTableView: UITableView!
    let identifierS:String = "SlideTableViewCell"
    var slideCell:SlideTableViewCell?
    let identifierL:String = "LaunchTableViewCell"
    var launchCell:LaunchTableViewCell?
    
    var imageCollCell:SlideImageCollectionViewCell?
    
    var launchResponse:[LaunchResponse] = []
    var launchUpcomingResponse:[LaunchUpcomingResponse] = []
    
    //var collIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        theTableView.registerCell(identifier: identifierS)
        theTableView.registerCell(identifier: identifierL)
        theTableView.dataSource = self
        theTableView.delegate = self
        
        DispatchQueue.global(qos: .userInitiated).sync {
            self.getRocketLaunches()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launchResponse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            slideCell = theTableView.dequeueReusableCell(withIdentifier: identifierS, for: indexPath) as? SlideTableViewCell
            
            slideCell?.theCollectionView.register(UINib(nibName:"SlideImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "slideImageCollCell")
            slideCell?.theCollectionView.dataSource = self
            slideCell?.theCollectionView.delegate = self
            
            //let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeRecognized))
            //slideCell?.cellView.addGestureRecognizer(swipe)
            
            return slideCell!
        }
        else {
            launchCell = theTableView.dequeueReusableCell(withIdentifier: identifierL, for: indexPath) as? LaunchTableViewCell
            
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
        imageCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "slideImageCollCell", for: indexPath) as? SlideImageCollectionViewCell

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
    /*
    @objc func swipeRecognized(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                collIndex -= 1
                (collIndex == -1) ? (collIndex = 0) : ()
                
                slideCell?.pageControl.currentPage = collIndex
                
                let index = IndexPath(row: collIndex, section: 0)
                slideCell?.theCollectionView.scrollToItem(at: index, at: .left, animated: true)
                
            case .down:
                print("Swiped down")
                
            case .left:
                collIndex += 1
                (collIndex > launchUpcomingResponse.count-1) ? (collIndex = launchUpcomingResponse.count-1) : ()
                
                slideCell?.pageControl.currentPage = collIndex
                
                let index = IndexPath(row: collIndex, section: 0)
                slideCell?.theCollectionView.scrollToItem(at: index, at: .right, animated: true)
                
            case .up:
                print("Swiped up")
                
            default:
                break
            }
        }
    }
    */
}

extension ListViewController {
    
    func getRocketLaunches() {
        appDelegate.rootVC.stateActivityIndicator(isOn: true)
        ServiceManager.shared.getRocketLaunches(parameters: nil) { (response, isOK) in
            appDelegate.rootVC.stateActivityIndicator(isOn: false)
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
    
    func getRocketLaunchesUpcoming() {
        appDelegate.rootVC.stateActivityIndicator(isOn: true)
        ServiceManager.shared.getRocketLaunchesUpcoming(parameters: nil) { (response, isOK) in
            appDelegate.rootVC.stateActivityIndicator(isOn: false)
            if isOK {
                self.fillUpcomingResponse(upcomingResponse: response ?? [])
            }
        }
    }
    
    func fillUpcomingResponse(upcomingResponse:[LaunchUpcomingResponse]) {
        for (_, responseData) in upcomingResponse.enumerated() {
            if responseData.links?.mission_patch != nil {
                launchUpcomingResponse.append(responseData)
            }
        }
        
        if launchUpcomingResponse.count < 2 {
            for index in 0..<3 {
                let newResponse = LaunchUpcomingResponse(mission_name: "Rocket \(index)", links: nil)
                launchUpcomingResponse.append(newResponse)
            }
        }
        
        DispatchQueue.main.async {
            self.slideCell?.theCollectionView.reloadData()
        }
    }
}
