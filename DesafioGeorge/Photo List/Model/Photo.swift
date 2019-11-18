//
//  Photo.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 15/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation
import ObjectMapper

class Photo: Mappable {
    
    var id: String!
    var description: String?
    var altDescription: String?
    var width: Int!
    var height: Int!
    var likes: Int?
    var urls: URLs!
    var user: User!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                          <- map["id"]
        description                 <- map["description"]
        altDescription              <- map["alt_description"]
        width                       <- map["width"]
        height                      <- map["height"]
        likes                       <- map["likes"]
        urls                        <- map["urls"]
        user                        <- map["user"]
    }
}

class PhotoView {
    
    var id: String
    var description: String
    var altDescription: String
    var width: Int
    var height: Int
    var likes: Int
    var thumbnail: UIImage?
    var image: UIImage?
    var urls: URLs
    var user: User
    
    init(photo: Photo) {
        id = photo.id
        description = photo.description ?? "No description"
        altDescription = photo.altDescription ?? ""
        width = photo.width
        height = photo.height
        likes = photo.likes ?? 0
        urls = photo.urls
        user = photo.user
    }
}

class PhotoModelView {
    static func loadImages(for photos: [Photo], _ completion: @escaping ([PhotoView]?) -> Void) {
        var downloadURLs: [URL] = []
        for photo in photos {
            let url = URL(string: photo.urls!.thumb!)!
            if ImageManager.retrieveImage(forKey: url.absoluteString, inStorageType: .userDefaults) == nil {
                downloadURLs.append(url)
            }
        }
        ImageManager.download(urls: downloadURLs) { (images) in
            var photoViews: [PhotoView] = []
            for photo in photos {
                let photoView = PhotoView(photo: photo)
                let url = URL(string: photo.urls!.thumb!)!
                if let image = ImageManager.retrieveImage(forKey: url.absoluteString, inStorageType: .userDefaults) {
                    photoView.thumbnail = image
                }
                photoViews.append(photoView)
            }
            completion(photoViews)
        }
    }
}
