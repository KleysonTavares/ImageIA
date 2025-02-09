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
    var homeCoordinator: HomeCoordinator?  // Referência para o HomeCoordinator

    init() {
        self.tabBarController = UITabBarController()
        self.navigationController = UINavigationController()
    }

    func start() {
        // Instanciando o HomeCoordinator
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator?.delegate = self  // TabBarCoordinator agora é o delegado de HomeCoordinator
        homeCoordinator?.start()

        let homeNavController = homeCoordinator?.navigationController
        homeNavController?.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        // Criar e configurar outras telas
        let searchViewController = UIViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)

        tabBarController.viewControllers = [homeNavController!, searchViewController]
    }
}

extension TabBarCoordinator: HomeCoordinatorDelegate {
    func didSelectItem() {
        print("Item selecionado na TabBarCoordinator")
    }
}
