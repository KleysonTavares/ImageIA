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
    var imageNavigationController: UINavigationController? // 🔹 Guarda referência da aba Search
    var settingsNavigationController: UINavigationController? // 🔹 Guarda referência da aba Settings
    var imageViewController: ImageViewController? // 🔹 Guarda referência do ImageViewController
    var settingsViewController: SettingsViewController? // 🔹 Guarda referência do SettingsViewController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        homeCoordinator = HomeCoordinator(navigationController: UINavigationController(), tabBarController: tabBarController, tabBarCoordinator: self)
        homeCoordinator?.start()

        guard let homeNavigationController = homeCoordinator?.navigationController else { return }
        homeNavigationController.tabBarItem = UITabBarItem(title: "Criar", image: UIImage(systemName: "house"), tag: 0)

        let imageVC = ImageViewController()
        self.imageViewController = imageVC // 🔹 Armazena referência para passar a imagem depois
        imageNavigationController = UINavigationController(rootViewController: imageVC)
        imageNavigationController?.tabBarItem = UITabBarItem(title: "Minhas Imagens", image: UIImage(systemName: "photo.on.rectangle"), tag: 1)

        let settingsVC = SettingsViewController()
        self.settingsViewController = settingsVC // 🔹 Armazena referência para passar a imagem depois
        settingsNavigationController = UINavigationController(rootViewController: settingsVC)
        settingsNavigationController?.tabBarItem = UITabBarItem(title: "Ajustes", image: UIImage(systemName: "gear"), tag: 1)

        guard let imageNav = imageNavigationController, let settingsNav = settingsNavigationController else { return }
        tabBarController.viewControllers = [homeNavigationController, imageNav, settingsNav]
        tabBarController.tabBar.tintColor = .purple  // Cor do ícone ativo
        tabBarController.tabBar.unselectedItemTintColor = .gray  // Cor dos ícones inativos
        tabBarController.tabBar.backgroundColor = .white  // Cor de fundo da TabBar
    }
}
