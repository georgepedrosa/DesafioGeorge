//
//  PhotoListView.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 15/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class PhotoListView: UIView {
    
    var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        return label
    }()
    
    var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "Likes"
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoTableViewCell")
        self.backgroundColor = .white
        self.addSubview(photoLabel)
        photoLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalToSuperview().inset(10)
        }
        self.addSubview(likesLabel)
        likesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in            make.top.equalTo(photoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
