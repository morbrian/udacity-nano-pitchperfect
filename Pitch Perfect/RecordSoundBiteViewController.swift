//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/7/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit
import AVFoundation

/*
  RecordSoundBiteViewController displays a button to start recording,
  and buttons to stop or pause recording once it is started.
  Clicking stop will segue to another view, handing off the information
  for retrieving the just completed recording.
*/

// TODO: BCM: would like to learn about localization and internationalization to replace these constants.
let InfoTapToRecord = "Tap to Record"
let InfoRecordingInProgress = "Recording in Progress"
let InfoRecordingPaused = "Recording Paused"

class RecordSoundBiteViewController: UIViewController, AVAudioRecorderDelegate {
    
    // TASK 4: Tap To Record label
    @IBOutlet weak var infoStatusLabel: UILabel!
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
    
    // figures out which of the three recording states we are in
    // and return the correct text for the info label.
    func deriveInfoText() -> String {
        if (!soundBiteManager.recordingInProgress) {
            return InfoTapToRecord
        } else if (soundBiteManager.recordingPaused) {
            return InfoRecordingPaused
        } else {
            return InfoRecordingInProgress
        }
    }

    func updateDisplay() {
        infoStatusLabel.text = deriveInfoText()
        recordButton.enabled = !soundBiteManager.recordingInProgress
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

