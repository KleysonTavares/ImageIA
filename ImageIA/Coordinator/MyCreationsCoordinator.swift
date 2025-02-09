//
//  MyCreationsCoordinator.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        let myCreationsVC = MyCreationsViewController()
        myCreationsVC.title = "Perfil"
        myCreationsVC.tabBarItem = UITabBarItem(title: "Perfil", image: UIImage(systemName: "person"), tag: 2)
        navigationController.viewControllers = [myCreationsVC]
    }
}

