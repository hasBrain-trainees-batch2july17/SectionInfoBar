//
//  ChannelEntity.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

class ChannelEntity: NSObject {
    var timedisplay: String?
    var programs = [ProgramEntity]()

    init(timedisplay: String, program: [ProgramEntity]) {
        self.timedisplay = timedisplay
        self.programs = program
    }

    init(json: [String: Any]) {
        self.timedisplay = json["timedisplay"] as? String
        if let items = json["items"] as? [Any] {
            for item in items {
                if let programJson = item as? [String: Any] {
                    self.programs.append(ProgramEntity(json: programJson))
                }
            }
        }
    }
//    func getProgram(at time: Date)->ProgramEntity?{
//        for item in programs {
//            if (item.timeStart?.compare(lessThan: time))! && (item.timeEnd?.compare(greaterThan: time))! {
//                return item
//            }
//        }
//        return nil
//    }
}
