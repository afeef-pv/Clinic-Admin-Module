//
//  ViewController.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit
import Parse

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var refreshControl = UIRefreshControl()

    let menus: [String] = ["Home","Upload","About"]
    
    var imageFile = UIImage(named: "cat")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //init hospital
        hospital = Hospital(profileName: "Hosptial Name", profileImage: UIImage(named: "cat")!, email: "hospital@mail.com", phone: "7352467899", addressLineOne: "Main address line", addressLineTwo: "Secondary address line")
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        
        //view.addSubview(refreshControl)
        
        setupCollectionView()
        setupMenuBar()
        
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    
    private func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "feedCellId")
        collectionView?.register(InfoCell.self, forCellWithReuseIdentifier: "infoCellId")
        collectionView?.register(AboutCell.self, forCellWithReuseIdentifier: "aboutCellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
        // Code to refresh table view
//        while true {
//            if reloadData() == true {
//                refreshControl.endRefreshing()
//                break
//            }
//        }
    }
    
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        
        let blockView = UIView()
        blockView.translatesAutoresizingMaskIntoConstraints = false
        blockView.backgroundColor = UIColor.appMainBlue
        view.addSubview(blockView)
        view.addSubview(menuBar)
        
        
        view.addFormatedConstraint(format: "H:|[v0]|", views: blockView)
        view.addFormatedConstraint(format: "V:[v0(50)]", views: blockView)
        
        view.addFormatedConstraint(format: "H:|[v0]|", views: menuBar)
        view.addFormatedConstraint(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCellId", for: indexPath) as? FeedCell
            cell?.homeController = self
            return cell!
        }
        else if indexPath.item == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCellId", for: indexPath) as? InfoCell
            cell?.profileImage.image = imageFile
            cell?.homeController = self
            cell?.titleField.delegate = self
            cell?.descriptionView.delegate = self
            return cell!
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutCellId", for: indexPath)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchor?.constant = scrollView.contentOffset.x / 3
    }
    
    func scrollToTab(tabIndex: Int){
        
        setTitle(index: tabIndex)
        let indexPath = NSIndexPath(item: tabIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath as IndexPath, at: .left, animated: true)
        
        
    }
    
    func setTitle(index: Int){
        navigationItem.title = menus[index]
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        setTitle(index: Int(index))
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
    }
    
    func reloadData()  {
        
        let cell = collectionView?.cellForItem(at: (NSIndexPath(item: 0, section: 0) as IndexPath)) as? FeedCell
        cell?.fetchPosts()
//        if let count = cell?.count {
//            while count > Int(0) {
//                if i >= (cell?.count)!{
//                    return true
//                }
//                i = i + 1
//            }
//        }
        //return false
    }
    
    func showPost(post: Post){
        
        print("Selected")
        let vc = PostViewController()
        vc.initView(post: post)
        vc.homeController = self
//        vc.postImage.image = post.image
//        vc.titleLabel.text = post.description
        //vc.descriptionView.text = post.name
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleChooseButton(_ sender: UIButton!){
        
        print("Working")
        let image = UIImagePickerController()
        image.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = true
        
        self.present(image, animated: true){
        //After loading
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageFile = image
            let cell = collectionView?.cellForItem(at: (NSIndexPath(item: 1, section: 0) as IndexPath)) as? InfoCell
            cell?.profileImage.image = imageFile
            cell?.titleField.text = (cell?.titleField.text!)!
        }
        else{
            print("Error occured on reloading data")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func upload(_ sender: Any) {
        
        if imageFile != nil{
            let imagePNG = UIImagePNGRepresentation(imageFile!)
            let parseImage = PFFile(name: "image.png", data: imagePNG!)
            let object = PFObject(className: "Offers")
            let cell = collectionView?.cellForItem(at: (NSIndexPath(item: 1, section: 0) as IndexPath)) as? InfoCell
            
            object["image"] = parseImage
            object["name"] = cell?.titleField.text
            object["description"] = cell?.descriptionView.text//cell?.description.text
            object["status"] = "active"
            
            object.saveInBackground { (success, error) in
                if success {
                    let cell = self.collectionView?.cellForItem(at: (NSIndexPath(item: 0, section: 0) as IndexPath)) as? FeedCell
                    cell?.fetchPosts()
                    self.collectionView?.reloadData()
                    let alert = UIAlertController(title: "Success", message: "Offer successfuly uploaded", preferredStyle: .alert)
                    
                    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: {
                        (alert:UIAlertAction) -> Void in
                    })
                    
                    alert.addAction(dismiss)
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    print(error ?? "Error")
                }
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("working")
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        
        return false
    }
    
}

