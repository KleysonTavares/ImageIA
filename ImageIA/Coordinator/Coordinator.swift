//
//  Coordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.start()
        window?.rootViewController = tabBarCoordinator.tabBarController
        window?.makeKeyAndVisible()
    }

}
