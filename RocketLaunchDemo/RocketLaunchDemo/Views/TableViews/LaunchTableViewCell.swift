//
// LaunchTableViewCell.swift
// RocketLaunchDemo
//
// Created on 16.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Kingfisher

class LaunchTableViewCell: UITableViewCell {

    @IBOutlet var theImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var cellViewHeightC: NSLayoutConstraint!
    
    let identifier:String = "LaunchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = UIColor.titleColor
        descriptionLabel.textColor = UIColor.textColor
        dateLabel.textColor = UIColor.textColor
        
        cellViewHeightC.constant = CGFloat(83).ws
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
}
