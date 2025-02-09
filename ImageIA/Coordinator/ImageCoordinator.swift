//
//  ImageCoordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class ImageCoordinator: Coordinator {
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        let imageVC = ImageViewController()
        imageVC.title = "Buscar"
        imageVC.tabBarItem = UITabBarItem(title: "Buscar", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        navigationController.viewControllers = [imageVC]
    }
}

