//
//  Extensions.swift
//  clinicAdminApp
//
//  Created by Afeef Pv on 01/10/18.
//  Copyright © 2018 PIXON. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat,green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
    }
    
    static let appMainBlue = rgb(red: 27, green: 60, blue: 137)
}


extension UIView{
    
    func addFormatedConstraint(format: String, views: UIView...){
        var viewDic = [String: UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            viewDic[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDic))
    }
}
