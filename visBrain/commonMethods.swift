//
//  commonMethods.swift
//  visBrain
//
//  Created by Apple on 05/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
    // Simple Navigation
    public func setNavigation (title:String,viewControlla:UIViewController) {
        let view = viewControlla.view
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 44))
        let navItem = UINavigationItem(title: title)
        navBar.setItems([navItem], animated: false)
        view?.addSubview(navBar)
    }
    
    

