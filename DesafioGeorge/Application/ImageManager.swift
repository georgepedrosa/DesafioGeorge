//
//  ImageDownloadManager.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

enum StorageType {
    case userDefaults
    case fileSystem
}

class ImageManager {
    
    static func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    static func retrieveImage(forKey key: String,
                                inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                return image
            }
        }
        
        return nil
    }
    
    static func store(image: UIImage,
                        forKey key: String,
                        withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation,
                                            forKey: key)
            }
        }
    }
    
    static func download(urls: [URL], _ completion: @escaping ([UIImage]?) -> Void) {
        var images: [UIImage] = []
        DispatchQueue.global().async {
            for url in urls {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                            ImageManager.store(image: image, forKey: url.absoluteString, withStorageType: .userDefaults)
                            images.append(image)
                    }
                }
            }
            completion(images)
        }
    }
    
    static func download(url: URL, _ completion: @escaping (UIImage?) -> Void) {

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                        ImageManager.store(image: image, forKey: url.absoluteString, withStorageType: .userDefaults)
                        completion(image)
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
}
