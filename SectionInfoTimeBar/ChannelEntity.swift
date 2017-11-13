//
//  ChannelEntity.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

class ChannelEntity: NSObject {
    var name: String?
    var programs = [ProgramEntity]()
    init(name: String, program: [ProgramEntity]) {
        self.name = name
        self.programs = program
    }
    
    func getProgram(at time: Date)->ProgramEntity?{
        for item in programs {
            if (item.timeStart?.compare(lessThan: time))! && (item.timeEnd?.compare(greaterThan: time))! {
                return item
            }
        }
        return nil
    }
}
