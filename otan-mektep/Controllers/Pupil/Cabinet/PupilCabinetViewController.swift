//
//  PupilCabinetViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit
import FirebaseAuth

class PupilCabinetViewController: UIViewController {
    
    @IBOutlet weak var logOutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        logOutButton.backgroundColor = .danger500
        logOutButton.layer.cornerRadius = 10
        logOutButton.titleLabel?.font = Fonts.body17.font
        logOutButton.setTitleColor(.white, for: .normal)

        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func logOut() {
        do {
            try Auth.auth().signOut()
            // Set the initial view controller to the login/signup view controller
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError)")
        }
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
