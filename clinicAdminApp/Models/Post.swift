//
//  Post.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

class Post{
    
    let description: String
    let image: UIImage
    let status: String
    let name: String
    let id: String
    
    init(description: String, image: UIImage, status: String, name: String,id: String) {
        
        self.description = description
        self.image = image
        self.status = status
        self.name = name
        self.id = id
        
    }
    
}
