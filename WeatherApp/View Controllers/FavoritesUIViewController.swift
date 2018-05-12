//
//  FavoritesUIViewController.swift
//  WeatherApp
//
//  Created by C4Q on 4/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favorites = [FavoriteImages]() {
        didSet {
            self.favoriteTableView.reloadData()
        }
    }
    lazy var favoriteTableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "imageCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(self.favoriteTableView)
        self.favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorite()
    }
    
    private func loadFavorite() {
        self.favorites = FileManagerHelper.manager.getAllFavoriteImages().reversed()
    }
}

