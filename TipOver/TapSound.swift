//
//  TapSound.swift
//  TipOver
//
//  Created by Don Wilson on 8/30/15.
//  Copyright © 2015 Don Wilson. All rights reserved.
//

import Foundation
import AVFoundation

class TapSound {
    
    private var tapSoundURL: NSURL = NSURL()
    private var tapSoundPlayer: AVAudioPlayer = AVAudioPlayer()
    
    static let sharedInstance: TapSound = {
        let instance = TapSound()
        
        instance.tapSoundURL = NSBundle.mainBundle().URLForResource("tap-professional", withExtension: "aif")!
        do { instance.tapSoundPlayer =  try AVAudioPlayer(contentsOfURL: instance.tapSoundURL, fileTypeHint: nil) }
        catch _ {print("open error"); return instance}
        
        instance.tapSoundPlayer.prepareToPlay()
        
        return instance
    }()
    
    func play() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let soundOn:Bool = defaults.boolForKey("soundOn")
        if soundOn {
            self.tapSoundPlayer.play()
        }
    }
    
}
