import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // Dashboard
        let dashboardVC = DashboardViewController()
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        dashboardNav.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house"), tag: 0)
        
        // Activities
        let activitiesVC = ActivitiesViewController()
        let activitiesNav = UINavigationController(rootViewController: activitiesVC)
        activitiesNav.tabBarItem = UITabBarItem(title: "Activities", image: UIImage(systemName: "figure.walk"), tag: 1)
        
        // Challenges
        let challengesVC = ChallengesViewController()
        let challengesNav = UINavigationController(rootViewController: challengesVC)
        challengesNav.tabBarItem = UITabBarItem(title: "Challenges", image: UIImage(systemName: "trophy"), tag: 2)
        
        // Profile
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [dashboardNav, activitiesNav, challengesNav, profileNav]
    }
}
