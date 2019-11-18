//
//  UnsplashRequestFactory.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 15/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class UnsplashRequestFactory {
    
    static func getPhotos() -> DataRequest {
        return Alamofire.request(baseURL + "photos/" + "?client_id=" + clientId + "&per_page=12", method: .get, encoding: JSONEncoding.default, headers: nil)
    }
}

