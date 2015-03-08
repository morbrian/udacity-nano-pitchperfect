//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/7/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgressLabel: UILabel!
    var recordingInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateDisplay() {
        recordingInProgressLabel.hidden = !recordingInProgress
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress = true
        updateDisplay()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress = false
        updateDisplay()
    }
    

}

