//
//  ViewController.swift
//  SectionInfoTimeBar
//
//  Created by Phi Tuoc Nguyen Van on 11/13/17.
//  Copyright © 2017 Phi Tuoc Nguyen Van. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellId"

class ViewController: UICollectionViewController {

    var listProgram: ChannelEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSectionInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let count = listProgram?.programs.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCustomCell
        // Configure the cell
        cell.channelName.text = listProgram?.programs[indexPath.row].subtitle
        cell.programName.text = listProgram?.programs[indexPath.row].title
        cell.thumbnailView.image = nil
        cell.channelImg.image = nil
        let thumbUrl = (listProgram?.programs[indexPath.row].imageURL)!
        let channelUrl = (listProgram?.programs[indexPath.row].channelImageURL)!
        DownloadHelper.downloadImage(url: thumbUrl) { (url, img) in
            if url == thumbUrl {

                cell.thumbnailView.image = img
            }
        }
        DownloadHelper.downloadImage(url: channelUrl) { (url, img) in
            if url == channelUrl {

                cell.channelImg.image = img
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }

    // ThumbView's element
    var thumbViewContainer: UIView?
    var thumbViewTime: UILabel?

    func setupSectionInfo() {
        // de allocate
        self.thumbViewContainer?.removeFromSuperview()
        //
        self.thumbViewContainer = {
            let thumb = UIView()
            thumb.backgroundColor = UIColor.white
            thumb.frame = CGRect(x: 0, y: 100, width: 150, height: 40)
            thumb.alpha = 0.3
            return thumb
        }()

        self.thumbViewTime = {
            let label = UILabel()
            label.text = "Wed 10:26 AM 🕐"
            return label
        }()

        //setup thumb's subview
        thumbViewContainer?.addSubview(thumbViewTime!)
        thumbViewContainer?.addConstraints(with: "H:|[v0]|", views: thumbViewTime!)
        thumbViewContainer?.addConstraints(with: "V:|[v0]|", views: thumbViewTime!)

        self.createPanGestureRecognizer(targetView: thumbViewContainer!)
        self.view.addSubview(thumbViewContainer!)
    }

    // The Pan Gesture
    func createPanGestureRecognizer(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        //
        targetView.removeGestureRecognizer(panGesture)
        //
        targetView.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let height = self.view.bounds.height

        var limited: (top: CGFloat, bottom: CGFloat) = (0, 0)
        limited.top = height / 10
        limited.bottom = height - height / 10
        let total = limited.bottom - limited.top
        let timeTotal = maxTime?.timeIntervalSince(minTime!)

        let translation = panGesture.translation(in: self.view)
        let centerY = panGesture.view!.center.y

        let position = centerY - limited.top

        let percent = position / total
        let timeChanged: Int = Int(CGFloat(timeTotal!) * percent)
        let t = Calendar.current.date(byAdding: .second, value: timeChanged, to: minTime!)


        if centerY <= limited.top {
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: limited.top + 1)
        }else if centerY >= limited.bottom {
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: limited.bottom - 1)
        }else{
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: centerY + translation.y)
        }

        switch panGesture.state {
        case .began:
            UIView.animate(withDuration: 0.3, animations: {
                self.thumbViewContainer?.alpha = 1
            })        case .changed:
                thumbViewTime?.text = "\(DateHelper.toString(from: t!))"
        case .ended:
            print("ended")
            let list: ChannelEntity? = self.getChannel(list: schedule, at: t!)
            //
            if listProgram?.timedisplay != list?.timedisplay || listProgram == nil {
                listProgram = list
                self.collectionView?.reloadData()
                if listProgram != nil {
                    self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                }
            }
            //
            print("time changed: \(DateHelper.toString(from: t!))")
            UIView.animate(withDuration: 0.3, animations: {
                self.thumbViewContainer?.alpha = 0.3
            })

        default:
            ()
        }


        panGesture.setTranslation(CGPoint.zero, in: self.view)
    }



    func getChannel(list: [ChannelEntity], at time: Date) ->  ChannelEntity? {
        // iterate all element in list
        // if find the element have timedisplay <= current display channel
        // Compare min time
        var sentinelChannel: ChannelEntity? = nil
        for channel in list {
            if let channelTimeDisplay = DateHelper.toDate(from: channel.timedisplay!) {
                if channelTimeDisplay.compare(time).rawValue <= 0 {
                    sentinelChannel = channel
                }
            }
        }
        return sentinelChannel
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }



}




