//
//  FileManger.swift
//  WeatherApp
//
//  Created by C4Q on 4/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//


import UIKit
class FileManagerHelper {
    private init() {}
    let favoriteImagesPath = "favoriteImages.plist"
    static let manager = FileManagerHelper()
    
    //Saving Images To Disk
    func saveImage(with imageID: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = imageID.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    func getImage(with imageID: String) -> UIImage? {
        do {
            let imagePathName = imageID.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private var favoriteImages = [FavoriteImages]() {
        didSet {
            removeDupes()
            saveImages()
        }
    }
    
    func removeDupes() {
        var imageIDSet = Set<String>()
        var noDupeArr = [FavoriteImages]()
        for favorite in favoriteImages {
            let (inserted, _) = imageIDSet.insert(favorite.title)
            if inserted {
                noDupeArr.append(favorite)
            }
        }
        if favoriteImages.count != noDupeArr.count { favoriteImages = noDupeArr }
    }
    
    func addNew(newFavoriteImage: FavoriteImages) {
        favoriteImages.append(newFavoriteImage)
    }
    func getAllFavoriteImages() -> [FavoriteImages] {
        return favoriteImages
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(favoriteImages)
            let imageURL = dataFilePath(withPathName: favoriteImagesPath)
            try encodedData.write(to: imageURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let imageURL = dataFilePath(withPathName: favoriteImagesPath)
            let encodedData = try Data(contentsOf: imageURL)
            let savedImages = try propertyListDecoder.decode([FavoriteImages].self, from: encodedData)
            favoriteImages = savedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //USE THIS ONE
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    //THIS IS ONLY FOR THE ABOVE METHOD
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
