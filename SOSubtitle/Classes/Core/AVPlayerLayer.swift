//
//  AVPlayerLayer.swift
//  SOSubtitle
//
//  Created by 邓锋 on 2018/9/5.
//  Copyright © 2018年 fengdeng. All rights reserved.
//

import Foundation
import AVKit

fileprivate var PlayerObKey = "PlayerObKey"
fileprivate var PlayerItemObKey = "PlayerItemObKey"
fileprivate var PlayerSubtitleLayer = "PlayerSubtitleLayer"

extension AVPlayerLayer {

    func startDisplaySubtitle(){
        player?.addPeriodicTimeObserver(forInterval: CMTimeMake(100, 600), queue: DispatchQueue.main) {[weak self] (time) in
            print(time.seconds)
            guard let `self` = self, let item = self.player?.currentItem else{return}
            for subtitle in item.subtitles{
                let range = CMTimeRangeMake(CMTime.init(seconds: subtitle.start, preferredTimescale: 600), CMTime.init(seconds: subtitle.duration, preferredTimescale: 600))
                if range.containsTime(time){
                    if self.subtitleLayer == nil{
                        let textLayer = CATextLayer.init()
                        textLayer.contentsScale = UIScreen.main.scale
                        textLayer.fontSize = 14
                        textLayer.alignmentMode = kCAAlignmentCenter
                        textLayer.font = UIFont.init(name: "Helvetica", size: 14)
                        textLayer.foregroundColor = UIColor.white.cgColor
                        self.subtitleLayer = textLayer
                        self.subtitleLayer?.frame = CGRect.init(x: self.videoRect.width / 2, y: self.videoRect.height, width: 10, height: 10)
                        self.addSublayer(textLayer)
                    }
                    item.currentSubtitle = subtitle
                    //添加描边 白字 黑边
                    let attStr = NSAttributedString.init(string: subtitle.text, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.strokeColor:UIColor.black,NSAttributedStringKey.strokeWidth:-1])
                    self.subtitleLayer?.string = attStr
                    let videoRect = self.videoRect
                    let textRect = self.subtitleLayer!.preferredFrameSize()
                    self.subtitleLayer?.frame = CGRect.init(x: (videoRect.width - textRect.width) / 2, y: videoRect.maxY - textRect.height, width: textRect.width, height: textRect.height)
                    return
                }
            }
            self.subtitleLayer?.string = nil
            item.currentSubtitle = nil
        }
    }
    
    
    var subtitleLayer : CATextLayer?{
        get{
            return objc_getAssociatedObject(self, &PlayerSubtitleLayer) as? CATextLayer
        }
        set{
            objc_setAssociatedObject(self, &PlayerSubtitleLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
