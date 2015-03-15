//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/7/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundBiteViewController: UIViewController, AVAudioRecorderDelegate {
    
    // TASK 4: Tap To Record label
    @IBOutlet weak var tapToRecordLabel: UILabel!
    @IBOutlet weak var recordingInProgressLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var soundBiteManager: SoundBiteManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        soundBiteManager = SoundBiteManager()
        soundBiteManager.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        updateDisplay()
    }

    func updateDisplay() {
        tapToRecordLabel.hidden = soundBiteManager.recordingInProgress
        recordButton.enabled = !soundBiteManager.recordingInProgress
        recordingInProgressLabel.hidden = !soundBiteManager.recordingInProgress
        stopButton.hidden = !soundBiteManager.recordingInProgress
        pauseButton.hidden = !soundBiteManager.recordingInProgress
    }

    @IBAction func recordAudio(sender: UIButton) {
        soundBiteManager.startRecording()
        updateDisplay()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        soundBiteManager.stopRecording()
        updateDisplay()
    }
    
    @IBAction func toggleRecording(sender: UIButton) {
        soundBiteManager.toggleRecording()
        updateDisplay()
    }
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        self.performSegueWithIdentifier("stopRecording", sender: soundBiteManager.lastRecordedSoundBite())
        updateDisplay()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundBiteViewController = segue.destinationViewController as PlaySoundBiteViewController
            let data = sender as SoundBite
            playSoundsVC.soundBite = data
        }
    }

}

