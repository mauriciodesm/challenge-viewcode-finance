//
//  TabBarController.swift
//  FinanceApp
//
//  Created by Vinicius on 13/10/22.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Atribuir delegate para que a VC utilize os metodos do delegate
        self.delegate = self

        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 0.5))
        lineView.backgroundColor = UIColor.systemGray
        tabBar.addSubview(lineView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //Criação da primeira tab
        let tabHome = HomeViewController()
        let tabHomeBarItem = UITabBarItem(title: "Home",
                                          image: UIImage(systemName: "house.fill"),
                                          selectedImage: nil)

        tabHome.tabBarItem = tabHomeBarItem

        //Criacao da segunda tab
        let tabTransfers = TransfersViewController()
        let tabTransfersBarItem = UITabBarItem(title: "Transfers",
                                               image: UIImage(systemName: "arrow.up.arrow.down"),
                                               selectedImage: nil)

        tabTransfers.tabBarItem = tabTransfersBarItem

        self.viewControllers = [
            UINavigationController(rootViewController: tabHome),
            tabTransfers
        ]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
}
