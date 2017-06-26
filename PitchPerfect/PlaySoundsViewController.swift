//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Boris Ruvinov on 6/17/17.
//  Copyright © 2017 BoRuv. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
	
	//MARK: Outlets
	
	@IBOutlet weak var slowButton: UIButton!
	@IBOutlet weak var fastButton: UIButton!
	@IBOutlet weak var highButton: UIButton!
	@IBOutlet weak var lowButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	var recordedAudioURL: URL!
	var audioFile: AVAudioFile!
	var audioEngine: AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	enum ButtonType: Int { case slow = 0, fast = 1, high = 2, low = 3, echo = 4, reverb = 5 }
	
	//MARK: Actions
	
	@IBAction func playSoundForButton(_ sender: UIButton) {
		switch (ButtonType(rawValue: sender.tag)!) {
		case .slow:
			playSound(rate: 0.5)
		case .fast:
			playSound(rate: 1.5)
		case .high:
			playSound(pitch: 1000)
		case .low:
			playSound(pitch: -1000)
		case .echo:
			playSound(echo: true)
		case .reverb:
			playSound(reverb: true)
		}
		
		configureUI(.playing)
	}
	
	@IBAction func stopButtonPressed(_ sender: AnyObject) {
		stopAudio()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupAudio()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUI(.notPlaying)
	}
}
