//
//  ProfileViewController.swift
//  Pokepedia
//
//  Created by Rivaldo Fernandes on 29/07/23.
//

import UIKit

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
