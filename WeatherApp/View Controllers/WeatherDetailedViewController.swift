//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by C4Q on 4/11/18.
//  Copyright © 2018 C4Q. All rights reserved.
////
import UIKit

class WeatherDetailedViewController:  UIViewController {
    var weather: Weather!
    var favoriteImage: FavoriteImages!
    var imageID: String = "" {
        didSet {
            self.favoriteImage = FavoriteImages(title: imageID)
        }
    }
    var dateCityTuple: (String, String) = ("", "") {
        didSet{
            self.dateCityLabel.text = "\(dateCityTuple.0)\nWeather Forcast for\n\(dateCityTuple.1)"
        }
    }
    lazy var dateCityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    lazy var weatherDescription: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return imageView
    }()
    lazy var infoTextViewRight: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isSelectable = false
       return textView
    }()
    
    lazy var infoTextViewVarRight: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .left

        return textView
    }()
    lazy var infoTextViewLeft: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .left
        return textView
    }()
    lazy var infoTextViewVarLeft: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.textAlignment = .left
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadSubViews()
        loadData()
        setConstraints()
    }
    func loadSubViews () {
    self.view.addSubview(dateCityLabel)
    self.view.addSubview(cityImageView)
    self.view.addSubview(weatherDescription)
    self.view.addSubview(infoTextViewRight)
    self.view.addSubview(infoTextViewLeft)
    self.view.addSubview(infoTextViewVarRight)
    self.view.addSubview(infoTextViewVarLeft)
    }
    func loadData () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveToFavorite))
        weatherDescription.text = weather!.weather
        infoTextViewRight.text = "Average Temp:\nWind:\nPressure:\nHumiity:"
        infoTextViewLeft.text =  "Feels Like:\nWind Direction:\nSun Rise:\nSunset:"
        infoTextViewVarRight.text = "\(weather!.avgTempF)\u{00B0}F\n\(weather!.windSpeedMPH) Mph\n\(weather!.pressureIN) Pa \n\(weather!.humidity)\u{0025}"
        let sunRise =  Models().getDateFormatted(from: weather.sunriseISO, format: "H:mm a")
        let sunSet = Models().getDateFormatted(from: weather.sunsetISO, format: "H:mm a")
        infoTextViewVarLeft.text = "\(weather!.feelslikeF)\u{00B0}F\n\(weather!.windDir)\n\(sunRise)\n\(sunSet)"
        self.dateCityTuple.1 = Models().getDateFormatted(from: weather!.dateTimeISO, format: "MMM dd")
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            CityNameHelper.manager.getLocationName(from: zipCode, completionHandler: { (cityinfo) in
                self.dateCityTuple.0 = cityinfo.0
                ClientAPI.manager.getPicture(cityName: cityinfo.0, completionHandler: { (image, imageID) in
                    self.cityImageView.image = image
                    self.imageID = imageID
                }, errorHandler: {print($0)})
            }, errorHandler: {print($0)})
        }
    }
    @objc func saveToFavorite() {
        FileManagerHelper.manager.addNew(newFavoriteImage: self.favoriteImage)
        if let image = cityImageView.image {
            FileManagerHelper.manager.saveImage(with: self.favoriteImage.title, image: image)
        }
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        let message = "Image Saved to Favorites"
        let avc = UIAlertController(title: "Saved", message: message, preferredStyle: .alert)
        avc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(avc, animated: true, completion: nil)
    }
    func setConstraints() {
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        cityImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cityImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        cityImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        cityImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        dateCityLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCityLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        dateCityLabel.bottomAnchor.constraint(equalTo: weatherDescription.topAnchor, constant: -20).isActive = true
        
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        weatherDescription.bottomAnchor.constraint(equalTo: cityImageView.topAnchor, constant: -20).isActive = true
        
        infoTextViewRight.translatesAutoresizingMaskIntoConstraints = false
        infoTextViewRight.trailingAnchor.constraint(equalTo: cityImageView.trailingAnchor).isActive = true
        infoTextViewRight.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 15).isActive = true
        infoTextViewRight.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4444).isActive = true
        infoTextViewRight.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        
        infoTextViewVarRight.translatesAutoresizingMaskIntoConstraints = false
        infoTextViewVarRight.trailingAnchor.constraint(equalTo: infoTextViewRight.trailingAnchor).isActive = true
        infoTextViewVarRight.topAnchor.constraint(equalTo: infoTextViewRight.topAnchor).isActive = true
        infoTextViewVarRight.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2222).isActive = true
        infoTextViewVarRight.bottomAnchor.constraint(equalTo: infoTextViewRight.bottomAnchor).isActive = true

        infoTextViewLeft.translatesAutoresizingMaskIntoConstraints = false
        infoTextViewLeft.trailingAnchor.constraint(equalTo: infoTextViewRight.leadingAnchor).isActive = true
        infoTextViewLeft.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 15).isActive = true
        infoTextViewLeft.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4444).isActive = true
        infoTextViewLeft.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true

        infoTextViewVarLeft.translatesAutoresizingMaskIntoConstraints = false
        infoTextViewVarLeft.trailingAnchor.constraint(equalTo: infoTextViewLeft.trailingAnchor).isActive = true
        infoTextViewVarLeft.topAnchor.constraint(equalTo: infoTextViewLeft.topAnchor).isActive = true
        infoTextViewVarLeft.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2222).isActive = true
        infoTextViewVarLeft.bottomAnchor.constraint(equalTo: infoTextViewLeft.bottomAnchor).isActive = true
    }

}

