//
//  Extension.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit


extension UIView {
    func addConstraints(with format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
