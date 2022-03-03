//
// SlideTableViewCell.swift
// RocketLaunchDemo
//
// Created on 16.01.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class SlideTableViewCell: UITableViewCell {

    @IBOutlet var cellView: UIView!
    @IBOutlet var theCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    
    let identifierS:String = "SlideTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
