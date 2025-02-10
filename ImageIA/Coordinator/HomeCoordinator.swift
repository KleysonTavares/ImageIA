//
//  HomeCoordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func didSelectItem()
}

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var tabBarCoordinator: TabBarCoordinator

    init(navigationController: UINavigationController, tabBarController: UITabBarController, tabBarCoordinator: TabBarCoordinator) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.tabBarCoordinator = tabBarCoordinator
    }

    func start() {
        let homeVC = HomeViewController()
        homeVC.delegate = self
        navigationController.viewControllers = [homeVC]
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func didTapSearchButton(image: UIImage?) {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                guard let imageVC = self.tabBarCoordinator.imageViewController else { return }
                imageVC.image = image
                imageVC.updateImage()
                self.tabBarController.selectedIndex = 1
            }
        }
    }
}
