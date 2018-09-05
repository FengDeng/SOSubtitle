//
//  AVPlayerItem.swift
//  SOSubtitle
//
//  Created by 邓锋 on 2018/9/5.
//  Copyright © 2018年 fengdeng. All rights reserved.
//

import Foundation
import AVKit


fileprivate var AVPlayerItemSubtitlesKey = "AVPlayerItemSubtitlesKey"
fileprivate var AVPlayerItemCurrentSubtitleKey = "AVPlayerItemCurrentSubtitleKey"

extension AVPlayerItem{
    
    var subtitles : [SOSubtitle]{
        get{
            return (objc_getAssociatedObject(self, &AVPlayerItemSubtitlesKey) as? [SOSubtitle]) ?? []
        }
        set{
            objc_setAssociatedObject(self, &AVPlayerItemSubtitlesKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var currentSubtitle : SOSubtitle?{
        get{
            return objc_getAssociatedObject(self, &AVPlayerItemCurrentSubtitleKey) as? SOSubtitle
        }
        set{
            objc_setAssociatedObject(self, &AVPlayerItemCurrentSubtitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}
