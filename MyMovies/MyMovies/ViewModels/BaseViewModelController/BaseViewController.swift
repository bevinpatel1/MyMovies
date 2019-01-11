//
//  BaseViewController.swift
//  MyMovies
//
//  Created by MAC193 on 1/10/19.
//  Copyright © 2019 MAC193. All rights reserved.
//

import UIKit
import RxSwift
import MBProgressHUD

class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setEventBinding()
        self.setDataBinding()
    }
    // Will called after viewdidload of superclass. We will do UI related code in this override function
    func setUI(){
    }
    // Will called after setUI of self. We will do event binding in this override function
    func setEventBinding(){
    }
    // Will called after setEventBinding of self. We will do data binding in this override function
    func setDataBinding(){
    }
    func showAlertDialogue( title: String , message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func showActivityIndicator(in _containerView:UIView? = nil) -> Void {
        
        var containerView:UIView = self.view
        if let _containerView = _containerView {
            containerView = _containerView
        }
        hideActivityIndicator(from: containerView)
        
        let hud = MBProgressHUD.showAdded(to: containerView, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.backgroundView.color = UIColor.black.withAlphaComponent(0.3)
        hud.backgroundView.style = .solidColor
        hud.show(animated: true)
    }
    
    func hideActivityIndicator(from _containerView:UIView? = nil) -> Void {
        
        var containerView:UIView = self.view
        if let _containerView = _containerView {
            containerView = _containerView
        }
        MBProgressHUD.hide(for: containerView, animated: true)
    }
}
