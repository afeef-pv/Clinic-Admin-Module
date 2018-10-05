//
//  MenuBar.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

//
//  MenuBar.swift
//  userAppClinic
//
//  Created by Afeef Pv on 28/09/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    var homeController: HomeController?
    
    let tabImages: [UIImage] = [UIImage(named: "Tab1")!,UIImage(named: "Tab5")!,UIImage(named: "Tab2")!]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor.red
        
        cv.dataSource = self
        cv.delegate = self
        return cv
        
    }()
    
    var horizontalBarLeftAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) { //initilizer
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        
        addFormatedConstraint(format: "H:|[v0]|", views: collectionView)
        addFormatedConstraint(format: "V:|[v0(50)]|", views: collectionView)
        
        let selectedIndexPath =  NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .bottom)
        
        setupHorizontalBar()
    }
    
    
    
    
    
    private func setupHorizontalBar(){ //Horizontal navigation indicator
        let horizontalBar = UIView()
        horizontalBar.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        addSubview(horizontalBar)
        horizontalBar.translatesAutoresizingMaskIntoConstraints = false
        
        horizontalBarLeftAnchor = horizontalBar.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchor?.isActive = true // X cordinate  of Horizantal bar
        horizontalBar.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true // Y cordinate of Horizontal
        horizontalBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        horizontalBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.backgroundColor = UIColor.appMainBlue // manubar color
        cell.tabImage.image = tabImages[indexPath.item].withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * frame.width / 3
        horizontalBarLeftAnchor?.constant = x
        
        homeController?.scrollToTab(tabIndex: indexPath.item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class MenuCell: BaseCell{
    var tabImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Tab1")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor(white: 1.0,alpha: 0.68)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            tabImage.tintColor = isHighlighted ? UIColor.white : UIColor(white: 1.0,alpha: 0.68)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            tabImage.tintColor = isSelected ?  UIColor.white : UIColor(white: 1.0,alpha: 0.68)
        }
    }
    
    override func setupViews() {
        addSubview(tabImage)
        
        addConstraint(NSLayoutConstraint(item: tabImage, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: tabImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}

