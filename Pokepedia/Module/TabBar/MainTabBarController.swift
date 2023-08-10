//
//  MainTabBarController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 02/08/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTabs()
    }
    
    private func setupTabs() {
        let homeRouter = HomeRouter.start()
        guard let homeVC = homeRouter.entry else { return }
        
        let homeNavItem = self.createNav(with: "List", and: UIImage(systemName: "list.bullet.below.rectangle"), vc: homeVC)
        
        let favoriteRouter = FavoriteRouter.createFavorite()
        guard let favoriteVC = favoriteRouter.entry else { return }
        
        let favoriteNavItem = self.createNav(with: "Favorite", and: UIImage(systemName: "heart"), vc: favoriteVC)
    
        let profileRouter = ProfileRouter.createProfile()
        guard let profileVC = profileRouter.entry else { return }
        
        let profileNavItem = self.createNav(with: "Profile", and: UIImage(systemName: "person"), vc: profileVC)
        
        self.setViewControllers([homeNavItem, favoriteNavItem, profileNavItem], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }

}
