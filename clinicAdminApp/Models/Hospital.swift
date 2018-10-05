//
//  Hospital.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

class Hospital {
    
    let profileName: String
    let profileImage: UIImage
    let email: String
    let phone: String
    let addressLineOne: String
    let addressLineTwo: String
    
    init(profileName: String, profileImage: UIImage, email: String, phone: String, addressLineOne: String, addressLineTwo: String) {
        self.profileName = profileName
        self.profileImage = profileImage
        self.email = email
        self.phone = phone
        self.addressLineOne = addressLineOne
        self.addressLineTwo = addressLineTwo
    }
    
    func saveToDb(){
        
    }
    
}

