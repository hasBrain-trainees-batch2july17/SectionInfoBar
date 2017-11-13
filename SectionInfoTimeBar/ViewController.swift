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
    
    var listProgram = [(channel: String, program: ProgramEntity)]()
    
    // ThumbView's element
    let thumbViewContainer: UIView = {
        var thumb = UIView()
        thumb.backgroundColor = UIColor.white
        thumb.frame = CGRect(x: 0, y: 100, width: 150, height: 40)
        thumb.alpha = 0.3
        return thumb
    }()
    let thumbViewTime: UILabel = {
        var label = UILabel()
        label.text = "Wed 10:26 AM 🕐"
        return label
    }()
    func setupView(){
        
        //setup thumb's subview
        thumbViewContainer.addSubview(thumbViewTime)
        thumbViewContainer.addConstraints(with: "H:|[v0]|", views: thumbViewTime)
        thumbViewContainer.addConstraints(with: "V:|[v0]|", views: thumbViewTime)
        
        //setup self.view
        self.view.addSubview(thumbViewContainer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(CollectionCustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // subView manager
        setupView()
        
        createPanGestureRecognizer(targetView: thumbViewContainer)
        
    }
    
    // The Pan Gesture
    func createPanGestureRecognizer(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(panGesture:)))
        targetView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        let hidght = self.view.bounds.height
        
        var limited: (top: CGFloat, bot: CGFloat) = (0, 0)
        limited.top = hidght / 10
        limited.bot = hidght - hidght / 10
        let total = limited.bot - limited.top
        let timeTotal = maxTime.timeIntervalSince(minTime)
        
        let translation = panGesture.translation(in: self.view)
        let centerY = panGesture.view!.center.y
        
        let position = centerY - limited.top
        
        let percent = position / total
        let timeChanged: Int = Int(CGFloat(timeTotal) * percent)
        let t = Calendar.current.date(byAdding: .second, value: timeChanged, to: minTime)
        
        
        if centerY <= limited.top {
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: limited.top + 1)
        }else if centerY >= limited.bot{
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: limited.bot - 1)
        }else{
            panGesture.view!.center = CGPoint(x: panGesture.view!.center.x, y: centerY + translation.y)
        }
        
        switch panGesture.state {
        case .began:
            UIView.animate(withDuration: 0.3, animations: {
                self.thumbViewContainer.alpha = 1
            })        case .changed:
                thumbViewTime.text = "\(DateHelper.string(from: t!))"
        case .ended:
            print("ended")
            var list = [(channel: String, program: ProgramEntity)]()
            for channel in schedule {
                if let prog = channel.getProgram(at: t!) {
                    list.append((channel: channel.name!, program: prog))
                }
            }
            listProgram = list
            collectionView?.reloadData()
            print("time changed: \(DateHelper.string(from: t!))")
            
            UIView.animate(withDuration: 0.3, animations: {
                self.thumbViewContainer.alpha = 0.3
            })
            
        default:
            ()
        }
        
        
        panGesture.setTranslation(CGPoint.zero, in: self.view)
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
        return listProgram.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCustomCell
        // Configure the cell
        cell.channelName.text = listProgram[indexPath.row].channel
        cell.programName.text = listProgram[indexPath.row].program.title
        cell.thumbnailView.backgroundColor = listProgram[indexPath.row].program.thumbnail
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
}

