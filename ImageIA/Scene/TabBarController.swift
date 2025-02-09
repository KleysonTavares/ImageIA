//
//  TabBarController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = HomeViewController()
        let imageVC = ImageViewController()
        let myCreationsVC = MyCreationsViewController()
        let settingsVC = SettingsViewController()

        // Criando os itens da TabBar
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        imageVC.tabBarItem = UITabBarItem(title: "Image", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        myCreationsVC.tabBarItem = UITabBarItem(title: "Criations", image: UIImage(systemName: "person"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Config", image: UIImage(systemName: "gear"), tag: 3)

        // Criando os NavigationControllers para cada aba
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: imageVC)
        let profileNav = UINavigationController(rootViewController: myCreationsVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)

        // Adicionando as abas na TabBar
        viewControllers = [homeNav, searchNav, profileNav, settingsNav]

        // Customizando a TabBar (opcional)
        tabBar.tintColor = .purple  // Cor do ícone ativo
        tabBar.unselectedItemTintColor = .gray  // Cor dos ícones inativos
        tabBar.backgroundColor = .white  // Cor de fundo da TabBar
    }
}

