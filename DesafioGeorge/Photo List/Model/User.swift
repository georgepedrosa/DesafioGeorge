//
//  User.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 17/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id: String!
    var name: String?
    var location: String?
    var profileImage: ProfileImage?
    var totalPhotos: Int!
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                          <- map["id"]
        name                        <- map["name"]
        location                    <- map["location"]
        profileImage                <- map["profile_image"]
        totalPhotos                 <- map["total_photos"]
    }
}

class ProfileImage: Mappable {
    var small: String?
    var medium: String?
    var large: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        small                           <- map["small"]
        medium                          <- map["medium"]
        large                           <- map["large"]
    }
    
    func getImageURL() -> URL? {
        if let string = medium {
            return URL(string: string)
        }
        return nil
    }
}
