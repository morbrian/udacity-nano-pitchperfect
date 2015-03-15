//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Brian Moriarty on 3/12/15.
//  Copyright (c) 2015 Brian Moriarty. All rights reserved.
//

import Foundation

class SoundBite: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    // TASK1: RecordedAudio class initializes with two parameters (aka class SoundBite in my code)
    init(filePathUrl: NSURL!, title: String!) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
