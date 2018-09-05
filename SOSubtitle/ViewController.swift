//
//  ViewController.swift
//  SOSubtitle
//
//  Created by 邓锋 on 2018/9/4.
//  Copyright © 2018年 fengdeng. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var player : AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let asset = AVAsset.init(url: Bundle.main.url(forResource: "20180814152717897", withExtension: "mp4")!)
        let item = AVPlayerItem.init(asset: asset)
        
        let subtitle1 = SOSubtitle()
        subtitle1.text = "第一条字幕"
        subtitle1.start = 0
        subtitle1.duration = 2
        
        let subtitle2 = SOSubtitle()
        subtitle2.text = "第二条字幕"
        subtitle2.start = 3
        subtitle2.duration = 2
        
        let subtitle3 = SOSubtitle()
        subtitle3.text = "第三条字幕"
        subtitle3.start = 5
        subtitle3.duration = 2
        
        let subtitle4 = SOSubtitle()
        subtitle4.text = "第四条字幕"
        subtitle4.start = 7
        subtitle4.duration = 2
        
        let subtitle5 = SOSubtitle()
        subtitle5.text = "你说的什么12还是build 's three"
        subtitle5.start = 10
        subtitle5.duration = 112
        
        item.subtitles = [subtitle1,subtitle2,subtitle3,subtitle4,subtitle5]
        
        
        let player = AVPlayer.init(playerItem: item)
        let layer = AVPlayerLayer.init(player: player)
        layer.startDisplaySubtitle()
        self.view.layer.addSublayer(layer)
        layer.frame = self.view.bounds
        player.play()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

