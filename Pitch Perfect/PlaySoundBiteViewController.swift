//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/8/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit
import AVFoundation

let RateSlow: Float = 0.5
let RateFast: Float = 1.5
let PitchHigh: Float = 1000
let PitchLow: Float = -1000

class PlaySoundBiteViewController: UIViewController {

    var audioEngine: AVAudioEngine!
    var audioUnitTimePitch: AVAudioUnitTimePitch!
    var audioFile: AVAudioFile!

    var soundBite:SoundBite!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioUnitTimePitch = AVAudioUnitTimePitch()
        audioFile = AVAudioFile(forReading: soundBite.filePathUrl, error: nil)
    }
    
    @IBAction func playSlow(sender: UIButton) {
        NSLog("playSlow")
        playSoundBite(rate: RateSlow)
    }
    
    @IBAction func playFast(sender: UIButton) {
        NSLog("playFast")
        playSoundBite(rate: RateFast)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        NSLog("playChipmunk")
        playSoundBite(pitch: PitchHigh)
    }
    
    @IBAction func playDarthvader(sender: UIButton) {
        NSLog("playDarthvader")
        playSoundBite(pitch: PitchLow)
    }
    
    func playSoundBite(rate: Float = 1.0, pitch: Float = 1.0) {
        // TASK 3: stop and reset the audio engine
        audioEngine.stop()
        audioEngine.reset()
        
        // Note: for some reason audioUnitTimePitch is not a reusable instance.
        var audioUnitTimePitch = AVAudioUnitTimePitch()
        audioUnitTimePitch.rate = rate
        audioUnitTimePitch.pitch = pitch
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioUnitTimePitch)
        
        audioEngine.connect(audioPlayerNode, to:audioUnitTimePitch, format:nil)
        audioEngine.connect(audioUnitTimePitch, to:audioEngine.outputNode, format:nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }
    
    @IBAction func stop(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
