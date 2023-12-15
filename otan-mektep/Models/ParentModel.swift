//
//  ParentModel.swift
//  otan-mektep
//
//  Created by Magzhan Zhumaly on 14.12.2023.
//

import UIKit

class NewsModel {
    let id: UUID = UUID()
    let image: UIImage?
    let title: String
    let count: Int
    let url: URL?
        
    init(title: String, image: UIImage?, count: Int, url: URL) {
        self.title = title
        if let img = image {
            self.image = img
        } else {
            self.image = UIImage(named: "questionmark.app.fill")?.withTintColor(.lightGray)
        }
        self.count = count
        self.url = url
    }
    
    init(title: String, image: UIImage?, count: Int, url: String) {
        self.title = title
        if let img = image {
            self.image = img
        } else {
            self.image = UIImage(named: "questionmark.app.fill")?.withTintColor(.lightGray)
        }
        self.count = count
        self.url = URL(string: url)
    }
    
    init(title: String, image: UIImage?, url: URL) {
        self.title = title
        if let img = image {
            self.image = img
        } else {
            self.image = UIImage(named: "questionmark.app.fill")?.withTintColor(.lightGray)
        }
        self.url = url
        self.count = 0
    }
    
//    init(title: String, count: Int, url: String) {
//        self.title = title
//        self.count = count
//        self.url = URL(string: url) ?? <#default value#>
//    }
//
//    init(title: String, url: String) {
//        self.title = title
//        self.url = url
//        self.count = 0
//    }
}
