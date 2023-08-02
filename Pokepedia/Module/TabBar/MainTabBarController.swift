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
    
    private func setupTabs(){
        let homeRouter = HomeRouter.start()
        guard let homeVC = homeRouter.begin else { return }
        
        let homeNavItem = self.createNav(with: "List", and: UIImage(systemName: "list.bullet.below.rectangle"), vc: homeVC)
        
        
        let favorite = self.createNav(with: "Favorite", and: UIImage(systemName: "heart"), vc: FavoriteViewController())
        
        
        
        let profileRouter = ProfileRouter.createProfile()
        guard let profileVC = profileRouter.entry else { return }
        
        let profileNavItem = self.createNav(with: "Profile", and: UIImage(systemName: "person"), vc: profileVC)
        
        
        self.setViewControllers([homeNavItem, favorite, profileNavItem], animated: true)
    }
    
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }

}
