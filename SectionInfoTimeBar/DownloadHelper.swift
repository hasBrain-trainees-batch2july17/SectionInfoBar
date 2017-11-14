//
//  Download.swift
//  SectionInfoTimeBar
//
//  Created by Phi Tuoc Nguyen Van on 11/14/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

class DownloadHelper {

    class public func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }

    class public func downloadImage(url: String, completion: @escaping (String, UIImage?) -> ()) {
        if let URL = URL(string: url) {
            getDataFromUrl(url: URL) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    let img = UIImage(data: data)
                    completion(url, img)
                }
            }
        }
    }
}
