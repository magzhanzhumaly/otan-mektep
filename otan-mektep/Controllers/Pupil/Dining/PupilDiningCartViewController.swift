//
//  PupilDiningCartViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 26.12.2023.
//

import UIKit

class PupilDiningCartViewController: UIViewController {
    @IBOutlet weak var topBarContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nav = Navigation.title("PupilDiningCartViewController",
                                   large: false,
                                   leftAction: [.init("Cancel", nil, false, { [weak self] in })],
                                   rightAction: [.init("Done", nil, false, { [weak self] in })])
        
        let topBar = AcadlyNavigation(style: nav, searchInfo: nil)
        
        topBarContainer.addFilledSubview(topBar)
        

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
