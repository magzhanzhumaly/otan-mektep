//
//  AppUtility.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit

open class AppUtility {
    class func onCancel(_ view: UIViewController , _ animated : Bool = false){
        if((view.presentingViewController) != nil){
            view.dismiss(animated: animated, completion: nil)
        }
    }
}
