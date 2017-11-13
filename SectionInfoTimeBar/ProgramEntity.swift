//
//  ProgramEntity.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

class ProgramEntity: NSObject {
    var title: String?
    var thumbnail: UIColor?
    var timeStart: Date?
    var timeEnd: Date?
    
    init(title: String, thumbnail: UIColor, start: String, end: String) {
        self.title = title
        self.thumbnail = thumbnail
        self.timeStart = DateHelper.date(from: start)
        self.timeEnd = DateHelper.date(from: end)
    }
}
