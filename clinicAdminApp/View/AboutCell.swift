//
//  AboutCell.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

class AboutCell: BaseCell {
    
    let profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cat")
        iv.layer.cornerRadius = 144
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "The Hospital Name"
        return label
    }()
    
    let firstAddressLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "First address line"
        label.textColor = .gray
        return label
    }()
    
    let secondAddressLine: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Second address line"
        label.textColor = .gray
        return label
    }()
    
    func initHospital(){
        
        companyName.text = hospital?.profileName
        profileImage.image = hospital?.profileImage
        firstAddressLine.text = hospital?.addressLineOne
        secondAddressLine.text = hospital?.addressLineTwo
        
    }
    
    override func setupViews() {
        
        initHospital()
        
        addSubview(profileImage) // Profile picture
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .height , relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 244))
        
        addConstraint(NSLayoutConstraint(item: profileImage, attribute: .width , relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 244))
        
        addSubview(companyName)// Company name
        addConstraint(NSLayoutConstraint(item: companyName, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: companyName, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 28))
        
        addSubview(firstAddressLine)// First address line
        addConstraint(NSLayoutConstraint(item: firstAddressLine, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: firstAddressLine, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: companyName, attribute: .bottom, multiplier: 1, constant: 8))
        
        addSubview(secondAddressLine)// Second address line
        addConstraint(NSLayoutConstraint(item: secondAddressLine, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: secondAddressLine, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: firstAddressLine, attribute: .bottom, multiplier: 1, constant: 8))
    }
    
}
