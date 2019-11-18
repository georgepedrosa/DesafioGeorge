//
//  UnsplashService.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 15/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class UnsplashService {
    
    var imagesRequest: Request?
    
    func getPhotos(_ completion: @escaping ([Photo], Error?) -> Void) {
        imagesRequest?.cancel()
        imagesRequest = UnsplashRequestFactory.getPhotos().validate().responseArray(completionHandler: { (response: DataResponse<[Photo]>) in
            switch response.result {
            case .success:
                if let photos = response.result.value {
                    completion(photos,nil)
                }
            case .failure:
                completion([], response.result.error)
            }
        })
    }
}
