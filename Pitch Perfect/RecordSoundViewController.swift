//
//  RecordSoundViewController.swift
//  Pitch Perfect
//
//  Created by Rajanikant Deshmukh on 27/11/17.
//  Copyright © 2017 Rajanikant Deshmukh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: IBOutlets
    
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    let recordingSegueId = "stopRecording"
    var audioRecorder: AVAudioRecorder!
    
    // MARK: UI Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(recording: false)
    }
    
    func configureUI(recording: Bool) {
        recordButton.isEnabled = !recording
        stopButton.isEnabled = recording
        recordLabel.text = recording ? "Recording.." : "Tap To Record"
    }

    // MARK: IBActions
    
    @IBAction func startRecording(_ sender: Any) {
        configureUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recording: false)
        
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    // MARK: AVAudioRecorderDelegate Functions
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        // Called after recording and saving file is finished
        if flag {
            performSegue(withIdentifier: recordingSegueId, sender: audioRecorder.url)
        } else {
            print("Recording Audio Failed")
        }
    }
    
    // MARK: Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == recordingSegueId) {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioUrl = sender as! URL
            playSoundVC.recordedAudioUrl = recordedAudioUrl
        }
    }
}

