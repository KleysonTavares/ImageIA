//
//  SettingsCoordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class SettingsCoordinator: Coordinator {
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        let settingsVC = SettingsViewController()
        settingsVC.title = "Config"
        settingsVC.tabBarItem = UITabBarItem(title: "Config", image: UIImage(systemName: "gear"), tag: 3)
        navigationController.viewControllers = [settingsVC]
    }
}

