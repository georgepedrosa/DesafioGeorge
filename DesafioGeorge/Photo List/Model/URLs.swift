//
//  URLs.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Foundation
import ObjectMapper

class URLs: Mappable {
    
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        raw                         <- map["raw"]
        full                        <- map["full"]
        regular                     <- map["regular"]
        small                       <- map["small"]
        thumb                       <- map["thumb"]
    }
}
