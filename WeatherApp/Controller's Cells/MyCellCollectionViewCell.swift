//
//  MyCellCollectionViewCell.swift
//  WeatherApp
//
//  Created by C4Q on 4/23/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MyCellCollectionViewCell: UICollectionViewCell {
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       return imageView
    }()
    lazy var lowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var highLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(lowLabel)
        self.contentView.addSubview(highLabel)
        setConstraints()
    }
    
    func setConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.bottomAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 8).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        lowLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20).isActive = true
        
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        highLabel.topAnchor.constraint(equalTo: lowLabel.bottomAnchor, constant: 15).isActive = true
    }
}


