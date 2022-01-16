//
// Extensions.swift
// RocketLaunchDemo
//
// Created on 16.01.2022.
// Oguzhan Yalcin
//
//
//

import UIKit
import AVKit
import AVFoundation
import Foundation

extension UITableView {
    
    func registerCell(identifier:String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.tableFooterView = UIView()
        self.rowHeight = UITableView.automaticDimension
        //self.estimatedRowHeight = 100.0
        self.separatorStyle = .none
    }
}

extension String {
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SS.SSSZ"
        if let theDate = dateFormatter.date(from:self) {
            return theDate
        }
        let currentDate = Date()
        return currentDate
    }
}

extension Date {
    
    func toString(formatType: String ) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatType
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
}

extension UIView {
    
    enum GradientColorDirection {
        case vertical
        case horizontal
    }
    
    func showGradientColors(_ colors: [UIColor], opacity: Float = 1, direction: GradientColorDirection = .vertical) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.opacity = opacity
        gradientLayer.colors = colors.map { $0.cgColor }

        if case .horizontal = direction {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.5, y: 0.0)
        }
        else if case .vertical = direction {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        gradientLayer.bounds = self.bounds
        gradientLayer.anchorPoint = CGPoint.zero
        self.layer.addSublayer(gradientLayer)
    }
}
