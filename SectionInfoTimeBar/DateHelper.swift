//
//  DateHelper.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//
import UIKit

class DateHelper {
    
    static func toDate(from string: String) -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormater.date(from: string)
    }
    
    static func toString(from date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "E HH:mm a"
        return dateFormater.string(from: date)
    }
}

class JsonReader {
    class public func readJson(path: String) -> [String: Any]? {
        do {
            if let file = Bundle.main.url(forResource: path, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    return object
                } else if let array = json as? [Any] {
                    // json is an array
                    print("json is array \(array)")
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
            return nil
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
