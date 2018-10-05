//
//  FeedCell.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit
import Parse

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    var posts: [Post] = []
    var count = 0
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellId = "cellId"
    
    override func setupViews(){
        
        collectionView.register(PostCell.self, forCellWithReuseIdentifier: cellId)
        fetchPosts()
        
        addSubview(collectionView)
        addFormatedConstraint(format: "H:|[v0]|", views: collectionView)
        addFormatedConstraint(format: "V:|[v0]|", views: collectionView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PostCell
        let post = posts[indexPath.item]
        cell?.thumbnailImageView.image = post.image
        cell?.titleLabel.text = post.description
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = frame.width - 32 * 9/16
        return CGSize(width: frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeController?.showPost(post: posts[indexPath.item])
    }
    
    func fetchPosts(){
        
        let query = PFQuery(className: "Offers")
        query.findObjectsInBackground { (objects, error) in
            if objects!.count > 0{
                self.count = objects!.count
                self.posts.removeAll()
                for object in objects!{
                    if let imageData = object["image"] as? PFFile{
                        
                        imageData.getDataInBackground(block: { (data, error) in
                            let imageData = UIImage(data: data!)
                            print("Success")
                            let offer = Post(description: object["description"] as! String, image: imageData as! UIImage, status: object["status"] as! String, name: object["name"] as! String,id: "object_id" as! String)
                            self.posts.append(offer)
                            self.collectionView.reloadData()
                            print("count \(String(describing: objects?.count))")
                            
                        })
                    }else{
                        
                        print("Cannot fetch")
                        
                    }
                }
                
                
            }else{
                print(error ?? "Something went wrong")
            }
        }
    }
    
}
