//
//  PhotoDetailsView.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class PhotoDetailsView: UIView {
    
    var rotateRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "rotateRight"), for: .normal)
        button.addTarget(self, action: #selector(rotateRight), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var rotateLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "rotateLeft"), for: .normal)
        button.addTarget(self, action: #selector(rotateLeft), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var heightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var widthLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var photographerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    var totalPhotosLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    init(frame: CGRect, photo: PhotoView) {
        super.init(frame: frame)
        setupView(photo: photo)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(photo: PhotoView) {
        self.backgroundColor = .white
        
        descriptionLabel.text = photo.description
        likesLabel.text = "Likes: " + String(photo.likes)
        heightLabel.text = "Height: " + String(photo.height) + " pixels"
        widthLabel.text = "Width: " + String(photo.width) + " pixels"
        photographerLabel.text = "Photographer: " + (photo.user.name ?? "Unknown")
        locationLabel.text = "Location: " + (photo.user.location ?? "Unknown")
        totalPhotosLabel.text = "Number of photos: " + String(photo.user.totalPhotos)
        
        self.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        self.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2.7)
        }
        self.addSubview(rotateRightButton)
        rotateRightButton.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.trailing.equalTo(photoImageView.snp.trailing).inset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        self.addSubview(rotateLeftButton)
        rotateLeftButton.snp.makeConstraints { (make) in
            make.top.equalTo(photoImageView.snp.bottom).offset(10)
            make.leading.equalTo(photoImageView.snp.leading).inset(20)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        self.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(rotateLeftButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        self.addSubview(heightLabel)
        heightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(likesLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        self.addSubview(widthLabel)
        widthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(heightLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
        }
        self.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(widthLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        self.addSubview(photographerLabel)
        photographerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(widthLabel.snp.bottom).offset(30)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(photographerLabel.snp.bottom).offset(10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        self.addSubview(totalPhotosLabel)
        totalPhotosLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    @objc func rotateRight() {
        photoImageView.image = photoImageView.image?.rotate(radians: .pi/2)
    }
    
    @objc func rotateLeft() {
        photoImageView.image = photoImageView.image?.rotate(radians: -.pi/2)
    }
}
