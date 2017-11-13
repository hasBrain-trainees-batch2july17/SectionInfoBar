//
//  Extension.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

extension Date {
    func compare(lessThan date: Date)->Bool{
        return Calendar.current.compare(self, to: date, toGranularity: .minute).rawValue == -1 ? true : false
    }
    func compare(greaterThan date: Date)->Bool{
        return Calendar.current.compare(self, to: date, toGranularity: .minute).rawValue == 1 ? true : false
    }
    func compare(equal date: Date)->Bool{
        return Calendar.current.compare(self, to: date, toGranularity: .minute).rawValue == 0 ? true : false
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
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
