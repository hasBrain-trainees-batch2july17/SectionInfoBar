//
//  CollectionCustomCell.swift
//  SectionInfoTimeBar
//
//  Created by Nguyen Pham on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

class CollectionCustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Element
    // image
    let thumbnailView: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = UIColor.random()
        
        return image
    }()
    
    // title
    let programName: UILabel = {
        var label = UILabel()
        label.text = "program's name"
        label.textColor = UIColor.white
        
        return label
    }()
    let channelName: UILabel = {
        var label = UILabel()
        label.text = "channel's name"
        label.textColor = UIColor.white
        
        return label
    }()
    
    func setupViews() {
        //        frame.size = CGSize(width: 200, height: 100)
        // add subview to container
        addSubview(programName)
        addSubview(thumbnailView)
        addSubview(channelName)
        
        // setup constraint for element
        self.addConstraints(with: "H:|-4-[v0]-4-|", views: thumbnailView)
        self.addConstraints(with: "H:|-4-[v0]-4-|", views: programName)
        self.addConstraints(with: "H:|-4-[v0]-4-|", views: channelName)
        self.addConstraints(with: "V:|-4-[v2(26)]-[v0]-[v1(26)]-4-|", views: thumbnailView, programName, channelName)
    }
}
