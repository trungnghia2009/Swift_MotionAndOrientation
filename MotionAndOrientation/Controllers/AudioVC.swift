//
//  AudioVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import AVFoundation

class AudioVC: UIViewController {
    
    // MARK: Properties
    private var audioPlayer: AVAudioPlayer!
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 60, height: 60)
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Audio Test"
        setupUI()
        loadAudioFile()
    }
    
    // MARK: Helpers
    private func setupUI() {
        view.addSubview(playButton)
        playButton.centerX(inView: view)
        playButton.centerY(inView: view)
    }
    
    private func loadAudioFile() {
        guard let audioFilePath = Bundle.main.path(forResource: "Sound", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl, fileTypeHint: nil)
            audioPlayer.numberOfLoops = 10
        } catch {
            print ("AVAudioPlayer error = \(error)")
        }
    }
    
    
    // MARK: Selectors
    @objc private func didTapPlayButton() {
        print("did tap play button...")
        audioPlayer.play()
    }

}
