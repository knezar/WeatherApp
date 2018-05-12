//
//  Models.swift
//  WeatherApp
//
//  Created by C4Q on 4/27/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation

class Models {
    var cityName = ""
    func getDateFormatted(from isoDate: String, format: String) -> String{
        let fromISODate = ISO8601DateFormatter()
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
        
        if let dateFromISODate = fromISODate.date(from: isoDate) {
            var stringFromDate = dateFormatter.string(from: dateFromISODate)
            if stringFromDate == dateFormatter.string(from: Date()) && format == format {
                stringFromDate = "Today"
            }
            return stringFromDate
        }
        return "N/A"
    }
}

struct WeatherToDay: Codable {
    let allInfo: [Response]
    
    enum CodingKeys: String, CodingKey {
        case allInfo = "response"
    }
}
struct Response: Codable {
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case weather = "periods"
    }
}
struct Weather: Codable {
    let validTime: String
    let dateTimeISO: String
    let maxTempC: Int
    let maxTempF: Int
    let minTempC: Int
    let minTempF: Int
    let avgTempC: Int
    let avgTempF: Int
    let pressureIN: Double
    let weather: String
    let windSpeedMPH: Int
    let icon: String
    let sunriseISO: String
    let sunsetISO: String
    let feelslikeC: Int
    let feelslikeF: Int
    let windDir: String
    let humidity: Int
    let precipIN: Double
}

struct CityImages: Codable {
    let webformatURL: String
    let id: Int
    
}
struct AllPictures: Codable {
    let picture: [CityImages]?
    
    enum CodingKeys: String, CodingKey {
        case picture = "hits"
    }
}

struct FavoriteImages: Codable {
    var title: String
}
