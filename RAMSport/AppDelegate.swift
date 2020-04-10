//
//  AppDelegate.swift
//  RAMSport
//
//  Created by rambo on 2020/2/12.
//  Copyright © 2020 rambo. All rights reserved.
//

import UIKit
import RealmSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var config = Realm.Configuration()
        let fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("db", isDirectory: true)
        let fileUrlStr = fileURL.path
        var isDirectory: ObjCBool = true
        if !FileManager.default.fileExists(atPath: fileUrlStr, isDirectory: &isDirectory) {
            do {
                try FileManager.default.createDirectory(at: fileURL, withIntermediateDirectories: true, attributes: nil)
                config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("db", isDirectory: true).appendingPathComponent("sport.realm")
            } catch {
            }
        } else {
            config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("db", isDirectory: true).appendingPathComponent("sport.realm")
        }
        Realm.Configuration.defaultConfiguration = config
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false;
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        window = UIWindow.init()
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        
        return true
    }

}

