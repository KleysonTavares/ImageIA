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

class HomeCoordinator: Coordinator, HomeViewControllerDelegate {
    var navigationController: UINavigationController
    var delegate: HomeCoordinatorDelegate?
    
    func didTapSearchButton(image: UIImage?) {
        let imageViewController = ImageViewController()
        imageViewController.receivedImage = image  // Passando a imagem para a ImageViewController
        navigationController.pushViewController(imageViewController, animated: true)
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let homeVC = HomeViewController()
        homeVC.delegate = self  // HomeCoordinator agora é o delegate do HomeViewController
        navigationController.pushViewController(homeVC, animated: false)
    }

}
