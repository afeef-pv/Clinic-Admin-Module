//
//  InfoCell.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

class InfoCell: BaseCell {
    
    var imageFile: UIImage!
    
    var homeController: HomeController? = HomeController()
    
    let profileImage: UIImageView  = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "cat")
        iv.contentMode = UIViewContentMode.scaleAspectFit
        return iv
    }()
    
    let chooseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap to choose from gallary", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleColor = UIColor.white
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.appMainBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleColor = UIColor.white
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.appMainBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    let titleField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "     Title"
        tf.layer.borderColor = (UIColor.appMainBlue.cgColor)
        tf.layer.borderWidth = 0.5
        tf.layer.cornerRadius = 8
        tf.returnKeyType = .done
        return tf
    }()
    
    let descriptionView: UITextView = {
       let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.layer.borderColor = (UIColor.appMainBlue.cgColor)
        tv.layer.borderWidth = 0.5
        tv.layer.cornerRadius = 8
        tv.isEditable = true
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.returnKeyType = .done
        return tv
    }()
    
    override func setupViews() {
        chooseButton.addTarget(homeController, action: #selector(homeController?.handleChooseButton(_: )), for: .touchUpInside)
        
        uploadButton.addTarget(homeController, action: #selector(homeController?.upload(_: )), for: .touchUpInside)
    
        addSubview(profileImage)
        addSubview(chooseButton)
        addSubview(titleField)
        addSubview(descriptionView)
        addSubview(uploadButton)
        
        titleField.borderRect(forBounds: CGRect(x: 0, y: 0, width: frame.width - 16, height: 30))
        
        addFormatedConstraint(format: "H:|[v0]|", views: profileImage)
        addFormatedConstraint(format: "V:|[v0(\(frame.height / 2))]-12-[v1(34)]-16-[v2(30)]-16-[v3(70)]-16-[v4(34)]-16-|", views: profileImage,chooseButton,titleField,descriptionView,uploadButton)
        
        addFormatedConstraint(format: "H:|-\(frame.width / 2 - 140)-[v0(280)]|", views: chooseButton)
        
        addFormatedConstraint(format: "H:|-8-[v0]-8-|", views: titleField)
        
        addFormatedConstraint(format: "H:|-8-[v0]-8-|", views: descriptionView)
        
        addFormatedConstraint(format: "H:|-\(frame.width / 2 - 60)-[v0(120)]|", views: uploadButton)

    }
    
}
