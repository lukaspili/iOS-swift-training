//
//  LoginGoogleViewController.swift
//  Training
//
//  Created by Lukasz on 07/04/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import Google

class LoginGoogleViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().uiDelegate = self
        
        let button = GIDSignInButton()
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(view)
        }
    }
    
    
}
