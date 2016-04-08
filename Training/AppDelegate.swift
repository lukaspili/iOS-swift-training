//
//  AppDelegate.swift
//  Training
//
//  Created by Lukasz on 15/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import Google

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Google sign in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(configureError)")
        GIDSignIn.sharedInstance().delegate = self
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.makeKeyWindow()
        window!.rootViewController = MapViewController()
        
        return true
    }
    

    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if (error == nil) {
            print("LOGGED IN: \(user.profile.email)")
        } else {
            print("\(error.localizedDescription)")
        }
        
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
    }
}

