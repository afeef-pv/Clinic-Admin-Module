//
//  PostCell.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class PostCell: BaseCell{
    
    
    
    let thumbnailImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Offer You Looking For!!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UITextView = {
        let label = UITextView()
        label.textColor = UIColor.lightGray
        label.text = "grab it before it ends !!!!"
        label.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews(){
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        
        //horizontal constraints
        addFormatedConstraint(format: "H:|[v0]|", views: thumbnailImageView)
        addFormatedConstraint(format: "H:|[v0]|", views: separatorView)
        addFormatedConstraint(format: "H:|-16-[v0(44)]|", views: profileImageView)
        
        
        //vertical constraints
        addFormatedConstraint(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,profileImageView,separatorView)
        
        
        
        //top constrain for title label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constrain for title label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constrain for title label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constrain for title label
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height , relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constrain for sub title label
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constrain for sub title label
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constrain for sub title label
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constrain for sub title label
        addConstraint(NSLayoutConstraint(item: subTitleLabel, attribute: .height , relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
    }
    
    
}
