//
//  TemplateData.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import Foundation

var minTime: Date? {
    let time = schedule.first?.timedisplay!
    return DateHelper.toDate(from: time!)
}
var maxTime: Date? {
    let time = schedule.last?.timedisplay!
    return DateHelper.toDate(from: time!)
}
var schedule: [ChannelEntity] = {
    var list = [ChannelEntity]()
    if let object = JsonReader.readJson(path: "content_page"), let datas = object["datas"] as? [Any] {
        for data in datas {
            if let channelJson = data as? [String: Any] {
                list.append(ChannelEntity(json: channelJson))
            }
            
        }
    }
    return list
}()
