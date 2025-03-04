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
    var homeViewController: HomeViewController?

    init(navigationController: UINavigationController, tabBarController: UITabBarController, tabBarCoordinator: TabBarCoordinator) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
        self.tabBarCoordinator = tabBarCoordinator
    }

    func start() {
        let homeVC = HomeViewController()
        homeViewController = homeVC
        homeVC.delegate = self
        navigationController.viewControllers = [homeVC]
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func didTapSearchButton(image: UIImage?) {
        DispatchQueue.main.async {
            let modalVC = ImageModalViewController()
            modalVC.image = image
            modalVC.modalPresentationStyle = .overFullScreen // Para cobrir a tela inteira com fundo transparente
            modalVC.modalTransitionStyle = .crossDissolve   // Efeito suave na transição
            self.navigationController.present(modalVC, animated: true, completion: nil)
        }
    }

    func didTapAspecRatioButton(aspectRatio: String) {
        DispatchQueue.main.async {
            let modalVC = AspectRatioViewController()
            modalVC.preferredContentSize = CGSize(width: 300, height: 400)
            modalVC.modalPresentationStyle = .formSheet
            modalVC.delegate = self.homeViewController
            modalVC.selectedAspectRatio = aspectRatio
            self.homeViewController?.present(modalVC, animated: true, completion: nil)
        }
    }
}
