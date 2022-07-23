//
// ActivityView.swift
// RocketLaunchDemo
//
// Created on 23.07.2022.
// Oguzhan Yalcin
//
//
//


import UIKit

class ActivityView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var message:String?
    
    init(frame: CGRect, message:String?) {
        self.message = message
        super.init(frame: frame)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        activity.startAnimating()
        messageLabel.text = message
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
