//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Boris Ruvinov on 6/15/17.
//  Copyright © 2017 BoRuv. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
	var audioRecorder: AVAudioRecorder!
	

	@IBOutlet weak var recordingLabel: UILabel!
	@IBOutlet weak var recordButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		stopRecordingButton.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
	}
	
	func configureUI(isRecording: Bool) {
		if isRecording {
			recordingLabel.text = "Recording in Progress"
		} else {
			recordingLabel.text = "Tap to Record"
		}
		stopRecordingButton.isEnabled = isRecording
		recordButton.isEnabled = !isRecording
	}
	
	@IBAction func recordAudio(_ sender: AnyObject) {
		configureUI(isRecording: true)
		
		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
		let recordingName = "recordeVoice.wav"
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
	
	@IBAction func stopRecording(_ sender: AnyObject) {
		configureUI(isRecording: false)
		
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
		} else {
			print("recording was not successful")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecording" {
			let playSoundsVC = segue.destination as! PlaySoundsViewController
			let recordedAudioURL = sender as! URL
			playSoundsVC.recordedAudioURL = recordedAudioURL
		}
	}
}

