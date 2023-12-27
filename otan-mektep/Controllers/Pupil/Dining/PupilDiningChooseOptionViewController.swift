//
//  PupilDiningViewController.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 22.12.2023.
//

import UIKit
import FirebaseAuth
class PupilDiningChooseOptionViewController: UIViewController {

    var user: User?

    @IBOutlet weak var vieww: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        vieww.backgroundColor = .gray50
//        let inp = FlexibleCell(input: .init(leftIcon: UIImage(named: "gov-active-icon 1"), title: "gov-active-icon 1", components: "gov-active-icon 1"))
//        let inp = FlexibleCell(input: .init(leftIcon: nil, title: "gov-active-icon 1", components: "gov-active-icon 1"))
        
//        let inp = FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "eye") ?? UIImage.appleLogo), color: .red), title: "hehe", components: .init(mainText: "lasdf", leftText: "asdf", lowerText: "asdf")))
//        let inp = FlexibleCell(input: .init(leftIcon: .init(icon: .cross, color: .accent), title: "h", components: .init(mainText: "hfd", leftText: "ef", lowerText: "hfasdf")))
        
//        let inp = FlexibleCell(input: .init(leftIcon: nil, title: "dhf", components: .init(input: .)))
        
//        let inp1 = FlexibleCell(input: .init(leftIcon: .init(icon: .cross, color: .accent), title: .init(text: "TITLE", isBold: true, isLarge: true), components: .init(input: .icon(icon: .next), color: nil), corners: .init(isRounded: true)))
        
        let inp2 = FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "eye") ?? UIImage.appleLogo), color: .danger400), title: .init(text: "my textdff\ndf", isBold: true, isLarge: true), components: .init(input: .title(text: .init(text: "dfdfjk", isBold: true, isLarge: true)), color: .danger300), corners: .init(isRounded: false)))

        let inp3 = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: "Желтоқсан", isBold: true, isLarge: false), components: .init(input: 
                .twoHorizontalLabels(leftText: .init(text: "dshfdhf", isBold: true, isLarge: true), rightText: "dfjksdfj")
                                                                                                                                                                                                                        , color: .danger300), corners: .init(isRounded: false)))
        
//        let inp4 = FlexibleCell(input: .init(leftIcon: nil, title: .init(text: "Желтоқсан", isBold: , isLarge: true), components: .init(input:
//                .twoVerticalLabels(upperText: "dfjk", lowerText: "dhsjfhh2o")                                                                                                                                                                                                                        , color: .danger300), corners: .init(isRounded: false)))
//        

//        let inp2 = FlexibleCell(input: .init(leftIcon: .init(icon: .other(image: UIImage(named: "eye") ?? UIImage.appleLogo), color: .danger400), title: .init(text: "my textdff\ndf", isBold: true, isLarge: false), components: .init(input: .title(text: .init(text: "dfdfjk", isBold: true, isLarge: false)), color: .danger300), corners: .init(isRounded: false)))


//
//                                let inp1 = FlexibleCell(input: .init(leftIcon: .init(icon: .cross, color: .accent), title: .init(text: "TITLE", isBold: true, isLarge: true), components: .init(input: .icon(icon: <#T##FlexibleCell.IconType#>), color: <#T##UIColor#>), corners: <#T##FlexibleCell.CornerInput?#>))

//        vieww.addFilledSubview(inp1)
        vieww.addFilledSubview(inp2)
//        vieww.addFilledSubview(inp3)
//        vieww.addFilledSubview(inp4)
//        vieww.addFilledSubview(inp5)

//        vieww.back
//        inp1.backgroundColor = .red
        print("usererr = \(user)")
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
