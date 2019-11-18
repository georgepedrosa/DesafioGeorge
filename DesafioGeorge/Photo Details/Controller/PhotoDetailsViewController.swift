//
//  PhotoDetailsViewController.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: BaseViewController {
    
    var photo: PhotoView!
    
    lazy var photoDetailsView: PhotoDetailsView = {
        let view = PhotoDetailsView(frame: .zero, photo: self.photo)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = photoDetailsView
        setupPhotos()
    }

    func setupPhotos() {
        let photoURL = URL(string: photo.urls.regular!)!
        let profileURL = photo.user.profileImage?.getImageURL()
        loadImage(url: photoURL) { (image) in
            self.photoDetailsView.photoImageView.image = image
            self.loadImage(url: profileURL!) { (image) in
                self.photoDetailsView.profileImageView.image = image
                self.stopIndicatorViewAnimation()
            }
        }
    }
    
    func loadImage(url: URL, _ completion: @escaping (UIImage?) -> Void) {
        if let image = ImageManager.retrieveImage(forKey: url.absoluteString, inStorageType: .userDefaults) {
            completion(image)
        } else {
            downloadImage(url: url) { (image) in
                completion(image)
            }
        }
    }
    
    func downloadImage(url: URL, _ completion: @escaping (UIImage?) -> Void) {
        startIndicatorViewAnimation()
        ImageManager.download(url: url) { (image) in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
