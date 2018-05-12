//
//  ErrorHandler.swift
//  WeatherApp
//
//  Created by C4Q on 5/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
enum AppError: Error {
    case noDataReceived
    case noConnection
    case badStatusCode
    case unKnown(rawError: Error)
    case couldNotParseJSON(rawError: Error)
}
