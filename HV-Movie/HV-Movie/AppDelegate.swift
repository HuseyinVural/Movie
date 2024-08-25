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
    var appCoordinator: AppCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        dependencyManager.registerDependencies()

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        
        return true
    }
}
