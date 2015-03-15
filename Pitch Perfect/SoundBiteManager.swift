//
//  SoundBiteManager.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/14/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//
// Manages the creation, listing, deletion of sound bite recordings.
//

import Foundation
import AVFoundation

class SoundBiteManager: NSObject, AVAudioRecorderDelegate {
    
    weak var delegate: AVAudioRecorderDelegate?
    
    // true when a recording is in progress
    var recordingInProgress: Bool {
        get {
            return biteInProgress != nil
        }
    }
    
    // date formatter used for new recoding files
    private let formatter = NSDateFormatter()
    
    // the sound bite currently being recorded, or nil when not recording
    private var biteInProgress: SoundBite!
    
    // list of all recorded sound bites
    private var soundBites = [SoundBite]()
    
    // reference to AudioRecorder used while we are recording
    private var audioRecorder:AVAudioRecorder!

    override init() {
        formatter.dateFormat = "ddMMyyyy-HHmmss"
    }
    
    //  create a new SoundBite and prepare it to hold a new recording
    func newSoundBite() -> SoundBite? {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // TASK1: calling constructor for RecordedAudio (aka SoundBite in my code)
        var soundBite = SoundBite(filePathUrl: filePath, title: recordingName)
        return soundBite
    }
    
    // start recording a new sound bite
    func startRecording() {
        biteInProgress = newSoundBite()
        audioRecorder = AVAudioRecorder(URL: biteInProgress.filePathUrl, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func toggleRecording() {
        if audioRecorder.recording {
            audioRecorder.pause()
        } else {
            audioRecorder.record()
        }
    }
    
    // stop recording
    func stopRecording() {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance();
        audioSession.setActive(false, error: nil)
    }
    
    // return the last sound bite that was recorded
    func lastRecordedSoundBite() -> SoundBite? {
        return soundBites.last
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // store the sound bite we just completed recording and reset recording state
        soundBites.append(biteInProgress)
        biteInProgress = nil
        audioRecorder = nil
        delegate?.audioRecorderDidFinishRecording!(recorder, successfully: flag)
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        delegate?.audioRecorderEncodeErrorDidOccur!(recorder, error: error)
    }
    
    func audioRecorderBeginInterruption(recorder: AVAudioRecorder!) {
        delegate?.audioRecorderBeginInterruption!(recorder)
    }
    

    func audioRecorderEndInterruption(recorder: AVAudioRecorder!, withOptions flags: Int) {
        delegate?.audioRecorderEndInterruption!(recorder, withOptions: flags)
    }
}