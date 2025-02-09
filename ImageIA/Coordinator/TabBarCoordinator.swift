//
//  TabBarCoordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var homeCoordinator: HomeCoordinator?
    var searchNavigationController: UINavigationController? // 🔹 Guarda referência da aba Search
    var imageViewController: ImageViewController? // 🔹 Guarda referência do ImageViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        homeCoordinator = HomeCoordinator(navigationController: UINavigationController(), tabBarController: tabBarController, tabBarCoordinator: self)
        homeCoordinator?.start()

        guard let homeNavigationController = homeCoordinator?.navigationController else { return }
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let imageVC = ImageViewController()
        self.imageViewController = imageVC // 🔹 Armazena referência para passar a imagem depois
        searchNavigationController = UINavigationController(rootViewController: imageVC)
        searchNavigationController?.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        tabBarController.viewControllers = [homeNavigationController, searchNavigationController!]
    }
}
