//
//  MenuLauncher.swift
//  flatlay
//
//  Created by Gross on 20/6/19.
//  Copyright © 2019 Oleksii Gnilov. All rights reserved.
//

import UIKit

class MenuLauncher: NSObject {

    // MARK: - PROPERTIES
    
    var mainView: UIView
    var isMenuPresented = false
    
    private let menu: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let height: CGFloat = 200
    
    
    // MARK: - INITIALIZING
    
    init(view: UIView) {
        self.mainView = view
        super.init()
    }
    
    
    // MARK: - MENU MANAGEMENT
    
    func showMenu() {
        
        mainView.addSubview(menu)
        let y = mainView.frame.height - height
        menu.frame = CGRect(x: 0, y: mainView.frame.height, width: mainView.frame.width, height: height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menu.frame = CGRect(x: 0, y: y, width: self.mainView.frame.width, height: self.height)
        }, completion: nil)
        
        isMenuPresented = true
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menu.frame = CGRect(x: 0, y: self.mainView.frame.height, width: self.mainView.frame.width, height: self.height)
        }, completion: nil)
        
        isMenuPresented = false
    }
    
}
