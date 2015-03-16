//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/8/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit
import AVFoundation

/*
  PlaySoundBiteViewController displays a variety of buttons to let the user
  play a recent recording with a desired audio effect.
*/

let RateSlow: Float = 0.5
let RateFast: Float = 2.0
let PitchHigh: Float = 1000
let PitchLow: Float = -1000
let ReverbWet: Float = 100

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
    
    @IBAction func stop(sender: UIButton) {
        audioEngine.stop()
        audioEngine.reset()
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
    
    @IBAction func playDarthVader(sender: UIButton) {
        NSLog("playDarthVader")
        playSoundBite(pitch: PitchLow)
    }
    
    @IBAction func playReverb(sender: UIButton) {
        NSLog("playReverb")
        playSoundBite(reverb: ReverbWet)
    }
    
    // plays audio with effects added by modifying any of the specified parameters
    func playSoundBite(rate: Float = 1.0, pitch: Float = 1.0, reverb: Float = 0) {
        // TASK 3: stop and reset the audio engine
        audioEngine.stop()
        audioEngine.reset()
        
        // TODO: (BCM): for some reason AVAudioUnit instances cannot be reused, i'm not sure why.
        var audioUnitTimePitch = AVAudioUnitTimePitch()
        audioUnitTimePitch.rate = rate
        audioUnitTimePitch.pitch = pitch
        
        var audioUnitReverb = AVAudioUnitReverb()
        audioUnitReverb.wetDryMix = reverb
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(audioUnitTimePitch)
        audioEngine.attachNode(audioUnitReverb)
        
        audioEngine.connect(audioPlayerNode, to:audioUnitTimePitch, format:nil)
        audioEngine.connect(audioUnitTimePitch, to:audioUnitReverb, format:nil)
        audioEngine.connect(audioUnitReverb, to:audioEngine.outputNode, format:nil)

        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
    }

}
