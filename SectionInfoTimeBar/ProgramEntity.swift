//
//  ProgramEntity.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

struct ShowSlot {
    var from: String?
    var to: String?
}

class ProgramEntity: NSObject {
    //
    var id: String?
    var imageURL : String?
    var channelImageURL: String?
    var title: String?
    var subtitle: String?
    var starttime: String?
    var endtime: String?
    var currentShowSlot: ShowSlot?

    init(json: [String: Any]) {
        self.id = json["id"] as? String
        self.imageURL = json["image"] as? String
        self.channelImageURL = json["channel_image"] as? String
        self.title = json["title"] as? String
        self.subtitle = json["subtitle"] as? String
        self.starttime = json["starttime"] as? String
        self.endtime = json["endtime"] as? String
        self.currentShowSlot = ShowSlot(from: json["from"] as? String, to: json["to"] as? String)
    }
}
