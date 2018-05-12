//
//  FavoritesUIViewControllerExtensions.swift
//  WeatherApp
//
//  Created by C4Q on 5/12/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

//MARK:- UITableView delegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
}

//MARK:- UITableView Data Source
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorite = self.favorites[indexPath.row]
        let cell = FavoriteTableViewCell(style: .default, reuseIdentifier: "imageCell")
        cell.favoriteImageView.image = FileManagerHelper.manager.getImage(with: favorite.title)
        cell.favoriteImageView.setNeedsLayout()
        return cell
    }
}

// MARK:- Setting constraints
extension FavoritesViewController {
    func tableViewConstraints() {
        self.favoriteTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.favoriteTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.favoriteTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.favoriteTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

