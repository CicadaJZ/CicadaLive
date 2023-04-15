//
//  BaseViewController.swift
//  CicadaLive
//
//  Created by 知了 on 2023/4/15.
//

import UIKit

class BaseViewController: UIViewController {
    
    var contenView : UIView?
    
    
    fileprivate lazy var animImageView: UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        imageView.animationRepeatCount = LONG_MAX
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    

}

extension BaseViewController {
    @objc func setupUI() {
        //
        contenView?.isHidden = true
        
        //
        view.addSubview(animImageView)
        
        //
        animImageView.startAnimating()
        
        //
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        //
        animImageView.stopAnimating()
        
        animImageView.isHidden = true
        
        contenView?.isHidden = false

    }
    

}
