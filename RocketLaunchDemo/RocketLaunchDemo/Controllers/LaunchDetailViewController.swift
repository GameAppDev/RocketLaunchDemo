//
// LaunchDetailViewController.swift
// RocketLaunchDemo
//
// Created on 15.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Kingfisher

class LaunchDetailViewController: UIViewController {

    @IBOutlet var backView: UIView!
    
    @IBOutlet var theImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var selectedLaunch:LaunchResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            self.setupViews()
        }
        
        DispatchQueue.global(qos: .userInitiated).sync { //called  first
            self.setSelectedLaunch()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        appDelegate.rootVC.topSafeArea.backgroundColor = UIColor.navBarBGColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        appDelegate.rootVC.topSafeArea.backgroundColor = UIColor.lightGray
    }
    
    func setupViews() {
        backView.backgroundColor = UIColor.navBarBGColor
    }
    
    func setSelectedLaunch() {
        if let launch = selectedLaunch {
            if let image = launch.links?.mission_patch {
                downloadImage(imageKey: image)
            }
            
            titleLabel.text = launch.mission_name
            descriptionLabel.text = launch.details
            
            if let rocketDate = launch.launch_date_utc {
                let launchDate = rocketDate.toDate()
                let formattedLaunchDate = launchDate.toString(formatType: "dd-MM-yyyy")
                dateLabel.text = formattedLaunchDate
            }
        }
    }
    
    func downloadImage(imageKey:String) {
        if let imageUrl = URL(string: imageKey) {
            DispatchQueue.main.async {
                let resource = ImageResource(downloadURL: imageUrl)
                
                self.theImageView.kf.setImage(with: resource, placeholder: UIImage(named: "EmptyRocketIcon"), options: [
                    .scaleFactor(UIScreen.main.scale),
                    //.transition(.fade(0.2)),
                    .cacheOriginalImage
                ]) { result in
                    switch result {
                    case .success(let value):
                        print("Image: \(value.image). Got from: \(value.cacheType)")
                    case .failure(let error):
                        print("Error: \(error)")
                        self.theImageView.image = UIImage(named: "EmptyRocketIcon")
                    }
                }
            }
        }
    }
    
    @IBAction func backClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
