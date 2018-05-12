//
//  ClientAPI.swift
//  WeatherApp
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//



import Foundation
import UIKit
struct ClientAPI {
    private init() {}
    static let manager = ClientAPI()
    private let clientId = "7TvNliIeesDcIRBJOkN7b"
    private let clientPWD = "0jHFi0GLcXPzHGvdTo4VZnY6t1A68TOuWKZcKgaf"
    private let keyAPI = "8857274-36307e4ac20455ab80ff6533a"
    func getWeather(from zipcode: String,
                    completionHandler: @escaping ([Weather]) -> Void,
                    errorHandler: @escaping (AppError) -> Void) {

        let urlWeather = "https://api.aerisapi.com/forecasts/\(zipcode)?client_id=\(clientId)&client_secret=\(clientPWD)"
        guard let url = URL(string: urlWeather) else {return}
        let parseDataWeather = {(data: Data) in
            do {
                let onlineWeather = try JSONDecoder().decode(WeatherToDay.self, from: data)
                if let getWeather = onlineWeather.allInfo.first {
                    completionHandler(getWeather.weather)
                    UserDefaultsHelper.manager.save(name: zipcode)
                }
                else {
                    errorHandler(.noDataReceived)
                    return
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataWeather, errorHandler: errorHandler)
    }
    //MARK:  ImageApi
    func getPicture(cityName: String,
                    completionHandler: @escaping (UIImage, String) -> Void,
                    errorHandler: @escaping (Error) -> Void) {
        var cityNameMutated = cityName
        if cityNameMutated.contains(" ") {
            cityNameMutated = cityNameMutated.replacingOccurrences(of: " ", with: "+")
        }
        let urlWeather = "https://pixabay.com/api/?key=\(keyAPI)&q=\(cityNameMutated)&image_type=photo&category=places"
        guard let url = URL(string: urlWeather) else {return}
        let parseDataImage = {(data: Data) in
            do {
                let onlinePicture = try JSONDecoder().decode(AllPictures.self, from: data)
                if let getPicture = onlinePicture.picture {
                    let rndIndex = Int(arc4random() % UInt32(getPicture.count))
                    let url = URL(string: getPicture[rndIndex].webformatURL)
                    if let imgCache = NSCacheHelper.manager.getImage(with: String(getPicture[rndIndex].id)) {
                        completionHandler(imgCache, String(getPicture[rndIndex].id))
                        return
                    }
                    do {
                        let dataImg = try Data.init(contentsOf: url!)
                        if let myImage = UIImage(data: dataImg) {
                            completionHandler(myImage, String(getPicture[rndIndex].id))
                            NSCacheHelper.manager.addImage(with: String(getPicture[rndIndex].id), and: myImage)
                        }
                    }
                } else {
                    errorHandler(AppError.noDataReceived)
                    return
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataImage, errorHandler: errorHandler)
    }
}
