//
//  ObjectDataSource.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

protocol PhotoListDataSourceDelegate: class {
    func photoSelected(photo: PhotoView)
}

class PhotoListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: PhotoListDataSourceDelegate!
    
    var photos = [PhotoView]()
    let cellId = "PhotoTableViewCell"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PhotoTableViewCell
        cell.bind(photo: photos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.photoSelected(photo: photos[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
