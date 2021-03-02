//
//  SplashViewController.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 01/03/2021.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.navigationController?.pushViewController(nextVC, animated: true)
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        }
    }
}
