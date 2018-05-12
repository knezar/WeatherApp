//
//  ViewController.swift
//  WeatherApp
//
//  Created by C4Q on 4/9/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let cellSpacing: CGFloat = 5.0
    let models = Models()
    var weathers = [Weather](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var cityName: String = ""{
        didSet {
        self.cityNameLabel.text = "\(cityName)\nWeather Forcast"
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center

        return label
    }()
    lazy var collectionView: UICollectionView = {
         let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(MyCellCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.placeholder = "ZipCode"
        textField.layer.borderWidth = 0.5
        textField.keyboardType = .numberPad
        textField.font = UIFont(name: textField.font!.fontName, size: 20)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 4
        return textField
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        searchTextField.delegate = self
        loadSubViews()
        loadData()
    }
    func loadSubViews () {
        view.addSubview(cityNameLabel)
        view.addSubview(collectionView)
        view.addSubview(searchTextField)
        setConstraints()
    }
     func loadData () {
        if let zipCode = UserDefaultsHelper.manager.getLastSearch() {
            self.searchTextField.text = UserDefaultsHelper.manager.getLastSearch()
            ClientAPI.manager.getWeather(from: zipCode, completionHandler: {self.weathers = $0}, errorHandler: {print($0)})
            CityNameHelper.manager.getLocationName(from: zipCode, completionHandler: {self.cityName = $0.0}, errorHandler: {print($0)})
        }
    }
    func setConstraints() {
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cityNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -10).isActive = true

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        searchTextField.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
    }
}

