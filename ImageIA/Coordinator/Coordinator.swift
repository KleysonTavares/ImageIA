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
        self.navigationController = UINavigationController()  // Esse NavigationController não precisa ser usado se você já tem o NavigationController no HomeCoordinator
    }

    func start() {
        let tabBarCoordinator = TabBarCoordinator()  // O TabBarCoordinator vai iniciar a navegação
        tabBarCoordinator.start()

        window?.rootViewController = tabBarCoordinator.tabBarController  // Aqui estamos usando o TabBarController
        window?.makeKeyAndVisible()
    }
}
