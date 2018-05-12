//
//  LocationHelper.swift
//  WeatherApp
//
//  Created by C4Q on 5/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import Foundation
import CoreLocation
class CityNameHelper {
    private init() {}
    static let manager = CityNameHelper()
    func getLocationName(from textFieldString: String, completionHandler: @escaping ((String, String)) -> Void, errorHandler: @escaping (Error) -> Void) {
        let geocoder = CLGeocoder()
        DispatchQueue.global(qos: .userInitiated).async {
           // Implement local search by name

            geocoder.geocodeAddressString(textFieldString){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let cityName = placemark.locality, let zipCode = placemark.postalCode  {
                        completionHandler((cityName, zipCode))
                    } else if let error = error {
                        errorHandler(error)
                    }
                }
            }
        }
    }
}
