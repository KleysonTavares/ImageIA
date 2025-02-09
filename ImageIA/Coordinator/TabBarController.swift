//
//  TabBarController.swift
//  ImageIA
//
//  Created by Kleyson Tavares on 08/02/25.
//

import UIKit

class TabBarController: UITabBarController {
    var homeCoordinator: HomeCoordinator?  // Já declarado no TabBarCoordinator

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        // Instanciar o HomeCoordinator apenas no TabBarCoordinator
        homeCoordinator?.start()  // Use o homeCoordinator já iniciado no TabBarCoordinator
    }
}

