//
//  AppDelegate.swift
//  HV-Movie
//
//  Created by Huseyin Vural on 24.08.2024.
//

import UIKit
import Data

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dependencyManager = DependencyManager()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencyManager.registerDependencies()

        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
