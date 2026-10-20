//
//  AppDelegate.swift
//  TemplateFlow
//
//  Created by Howard-Zjun on 2024/04/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navi = UINavigationController(rootViewController: ControlPanelViewController())
        navi.navigationBar.isHidden = true
        window.rootViewController = navi
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

