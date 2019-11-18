//
//  PhotoTableViewCell.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    func setupView() {
        self.addSubview(thumbnail)
        thumbnail.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.equalTo(70)
        }
        
        self.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(35)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(thumbnail.snp.trailing).inset(10)
            make.trailing.equalTo(likesLabel.snp.leading).offset(10)
        }
    }
    
    func bind(photo: PhotoView) {
        self.likesLabel.text = String(photo.likes)
        thumbnail.image = photo.thumbnail
        authorLabel.text = "by " + (photo.user.name ?? "Unknown")
    }
}
