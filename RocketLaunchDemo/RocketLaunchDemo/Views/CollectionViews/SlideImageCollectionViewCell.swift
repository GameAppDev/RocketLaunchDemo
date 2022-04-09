//
// SlideImageCollectionViewCell.swift
// RocketLaunchDemo
//
// Created on 16.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit
import Kingfisher

class SlideImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet var theLabel: UILabel!
    @IBOutlet var theImageView: UIImageView!
    
    let identifier:String = "slideImageCollCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        theLabel.textColor = UIColor.titleBlueColor
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
