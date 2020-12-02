//
//  MarvelObject.swift
//  MarvelApp
//
//  Created by Shubham Tunwal on 02/12/20.
//

import Foundation
import  UIKit
class MarvelObject:NSObject{
    
    
    var mImg :UIImage?
    var mName:String?
    var mDesc:String?
    
    
    internal init(mImg: UIImage? = nil, mName: String? = nil, mDesc: String? = nil) {
        self.mImg = mImg
        self.mName = mName
        self.mDesc = mDesc
    }

    
    
}
