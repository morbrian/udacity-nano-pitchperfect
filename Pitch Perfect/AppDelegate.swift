//
//  AppDelegate.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/7/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Fabric.with([Crashlytics()])
        return true
    }

}

