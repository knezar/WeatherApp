//
//  NSCacheHelper.swift
//  WeatherApp
//
//  Created by C4Q on 4/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit

class NSCacheHelper {
    private init() {}
    static let manager = NSCacheHelper()
    private var myCache = NSCache<NSString, UIImage>()
    func addImage(with imageID: String, and image: UIImage) {
        myCache.setObject(image, forKey: imageID as NSString)
    }
    func getImage(with imageID: String) -> UIImage? {
        return myCache.object(forKey: imageID as NSString)
    }
}

