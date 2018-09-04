//
//  ViewController.swift
//  SOSubtitle
//
//  Created by 邓锋 on 2018/9/4.
//  Copyright © 2018年 fengdeng. All rights reserved.
//

import UIKit
import AVKit

extension AVPlayerLayer {
    
    func selectSubtitle(url:URL?){
        guard let item = self.player?.currentItem else{return}
        let layer = AVSynchronizedLayer.init(playerItem: item)
        self.addSublayer(layer)
        layer.frame = self.bounds
        layer.masksToBounds = false
        
        let textLayer = CATextLayer.init()
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.string = "哈哈哈哈  大大大大 "
        textLayer.fontSize = 8
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.font = UIFont.init(name: "Helvetica", size: 8)
        textLayer.foregroundColor = UIColor.white.cgColor
        layer.addSublayer(textLayer)
        
        let animation = CAKeyframeAnimation.init(keyPath: "string")
        animation.beginTime = AVCoreAnimationBeginTimeAtZero
        animation.duration = item.duration.seconds
        animation.values = ["1","2","3","4","5"]
        //animation.keyTimes = [0.01,0.02,0.3,0.4,0.5]
        animation.calculationMode = kCAAnimationDiscrete
        textLayer.add(animation, forKey: "string")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print(self.videoRect)
            let videoRect = self.videoRect
            let textRect = textLayer.preferredFrameSize()
            textLayer.frame = CGRect.init(x: (videoRect.width - textRect.width) / 2, y: videoRect.maxY - textRect.height, width: textRect.width, height: textRect.height)
        }
        
//        let scrollLayer = CAScrollLayer.init()
//        scrollLayer.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: 50)
//
//        let containerLayer = CALayer()
//        containerLayer.anchorPoint = CGPoint.zero
//        containerLayer.frame = self.bounds
//
//
//
//        let subtitles = [SOSubtitle]()
//
//        let animation = CAKeyframeAnimation.init(keyPath: "position")
//        animation.beginTime = AVCoreAnimationBeginTimeAtZero
//        animation.duration = item.duration.seconds
//        animation.values = []
//        animation.keyTimes = []
//        animation.calculationMode = kCAAnimationDiscrete
//
        
        
    }
    
}

class ViewController: UIViewController {
    
    var player : AVPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let asset = AVAsset.init(url: Bundle.main.url(forResource: "20180814152717897", withExtension: "mp4")!)
        let item = AVPlayerItem.init(asset: asset)
        let player = AVPlayer.init(playerItem: item)
        let layer = AVPlayerLayer.init(player: player)
        self.view.layer.addSublayer(layer)
        layer.frame = self.view.bounds
        layer.selectSubtitle(url: Bundle.main.url(forResource: "20180814152717897", withExtension: "srt"))
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

