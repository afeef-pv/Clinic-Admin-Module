//
//  PostViewController.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController {
    
    var homeController: HomeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupviews()
    }
    func initView(post: Post){
        postImage.image = post.image
        titleLabel.text = post.name
        descriptionView.text = post.description
        self.id = post.name
    }
    var id: String = ""
    
    let postImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = UIViewContentMode.scaleAspectFit
        iv.image = UIImage(named: "cat")
        
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a title"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.text = "Description of the ads go right here!!"
        tv.textColor = .gray
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        let titleColor = UIColor.white
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor.appMainBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    func setupviews(){
        
        deleteButton.addTarget(self, action: #selector(deletePost(_: )), for: .touchUpInside)
        
        view.addSubview(postImage)// Post Image View
        view.addSubview(titleLabel)
        view.addSubview(descriptionView)
        view.addSubview(deleteButton)
        let height = view.frame.width * 16 / 9 - 300
        
        view.addFormatedConstraint(format: "H:|[v0]|", views: postImage)
        view.addFormatedConstraint(format: "H:|-8-[v0]-8-|", views: titleLabel)
        view.addFormatedConstraint(format: "H:|-8-[v0]-8-|", views: descriptionView)
        view.addFormatedConstraint(format: "H:|-\(view.frame.width / 2 - 60)-[v0(120)]|", views: deleteButton)
        view.addFormatedConstraint(format: "V:|[v0(\(height))]-8-[v1(34)]-8-[v2(48)]-18-[v3(34)]", views: postImage,titleLabel,descriptionView,deleteButton)
        
    }
    
    @objc func deletePost(_ sender: Any) {
        
        let query = PFQuery(className: "Offers")
        query.whereKey("name", equalTo: self.id)
        query.findObjectsInBackground {
            (objects, error) -> Void in
            for object in objects! {
                object.deleteInBackground(block: { (success, error) in
                    if success {
                        let alert = UIAlertController(title: "Success", message: "Post successfuly deleted", preferredStyle: .alert)
                        
                        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                            (alert:UIAlertAction) -> Void in
                            self.homeController?.collectionView?.reloadData()
                        })
                        
                        alert.addAction(dismiss)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Warning", message: error as! String, preferredStyle: .alert)
                        
                        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                            (alert:UIAlertAction) -> Void in
                            self.homeController?.collectionView?.reloadData()
                        })
                        
                        alert.addAction(dismiss)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
    }
}
