//
//  FavoriteTableViewCell.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/10/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.contentMode = .scaleToFill
        imageView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    func commonInit() {
        addSubview(favoriteImageView)
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        subViewConstraints()
    }
    
    private func subViewConstraints() {
        favoriteImageView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        favoriteImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        favoriteImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true          }
}

