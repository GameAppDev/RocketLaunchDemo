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
        
        setupViews()
        
        setSelectedLaunch()
    }
    
    func setSelectedLaunch() {
        if let launch = selectedLaunch {
            downloadImage(imageKey: launch.links?.mission_patch ?? "")
            
            titleLabel.text = launch.mission_name
            descriptionLabel.text = launch.details
            
            let launchDate = launch.launch_date_utc?.toDate()
            let formattedLaunchDate = launchDate?.toString(formatType: "dd-MM-yyyy")
            dateLabel.text = formattedLaunchDate
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

extension LaunchDetailViewController {
    
    func setupViews() {
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        backView.showGradientColors([
            UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1),
            UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        ], direction: .horizontal)
    }
}
