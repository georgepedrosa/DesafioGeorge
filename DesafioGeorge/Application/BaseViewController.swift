//
//  BaseViewController.swift
//  DesafioGeorge
//
//  Created by George Pedrosa on 16/11/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var indicatorBackgroundView: UIView = {
       return createBackgroundIndicatorView()
    }()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        return createIndicatorView()
    }()

    func presentAlert(withTitle title:String?, andMessage message:String?, confirmTitle: String = "Ok", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { action in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentErrorAlert(message: String? = nil, completion: (() -> Void)? = nil) {
        self.presentAlert(withTitle: "Erro", andMessage: message ?? "Ocorre um erro",completion: completion)
    }
    
    private func createBackgroundIndicatorView() -> UIView{
        let indicatorBackgroundView = UIView()
        
        view.addSubview(indicatorBackgroundView)
        
        indicatorBackgroundView.isHidden = false
        indicatorBackgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        indicatorBackgroundView.backgroundColor = .gray
        indicatorBackgroundView.bringSubviewToFront(view)
        
        return indicatorBackgroundView
    }
    
    
    private func createIndicatorView() -> UIActivityIndicatorView{
    
        let indicator = UIActivityIndicatorView()
        
        indicatorBackgroundView.addSubview(indicator)
        
        indicator.isHidden = false
        
        indicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        indicator.backgroundColor = .lightGray
        indicator.layer.cornerRadius = 10
        
        return indicator
    }
    
    func isIndicatorAnimationActivy() -> Bool{
        return loadingIndicatorView.isAnimating
    }
    
    func startIndicatorViewAnimation(){
        loadingIndicatorView.startAnimating()
        indicatorBackgroundView.isHidden = false
    }
    
    func stopIndicatorViewAnimation(){
        loadingIndicatorView.stopAnimating()
        indicatorBackgroundView.isHidden = true
    }
    
    func presentConnectionError() {
        self.stopIndicatorViewAnimation()
        self.presentErrorAlert(message: "Houve um problema com a conexão, verifique se o dispositivo está conectado a uma rede", completion: nil)
    }
}

