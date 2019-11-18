//
//  PhotoListViewController.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 15/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class PhotoListViewController: BaseViewController, PhotoListDataSourceDelegate {
    
    var service: UnsplashService!
    var dataSource = PhotoListDataSource()
    
    lazy var photoListView: PhotoListView = {
        let view = PhotoListView()
        view.tableView.delegate = dataSource
        view.tableView.dataSource = dataSource
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.view = photoListView
        dataSource.delegate = self
        service = UnsplashService()
        loadData()
    }
    
    func setupNavBar() {
        let addButton = UIBarButtonItem(title: "Limpar cache de imagens", style: .done, target: self, action: #selector(resetDefaults))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    func loadData() {
        startIndicatorViewAnimation()
        service.getPhotos { (photos, error) in
            if error == nil {
                PhotoModelView.loadImages(for: photos) { (photoViews) in
                    self.dataSource.photos = photoViews!
                    DispatchQueue.main.async { self.photoListView.tableView.reloadData()
                        self.stopIndicatorViewAnimation()
                    }
                }
            } else {
                self.stopIndicatorViewAnimation()
                self.presentErrorAlert(message: "Ocorreu um erro desconhecido.", completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoDetails" {
            let photoDetails = segue.destination as! PhotoDetailsViewController
            photoDetails.photo = (sender as! PhotoView)
        }
    }
    
    func photoSelected(photo: PhotoView) {
        performSegue(withIdentifier: "photoDetails", sender: photo)
    }
}
