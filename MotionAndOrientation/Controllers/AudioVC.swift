//
//  AudioVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import AVFoundation
import Combine

class AudioVC: UIViewController {
    
    // MARK: Properties
    private var audioPlayer = AVAudioPlayer()
    private var timer = Timer()
    private var secondsPassed = 0
    private var isStop = false
    private let notificationCenter = NotificationCenter.default
    private var appEventSubscribers = [AnyCancellable]()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "playButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: 300, height: 300)
        iv.image = UIImage(named: "Music")
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .systemBlue
        return progressView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Audio Test"
        setupUI()
        loadAudioFile()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removePlayer()
        timer.invalidate()
    }
    
    // MARK: Helpers
    private func setupUI() {
        
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)

        view.addSubview(playButton)
        playButton.setDimensions(width: 100, height: 100)
        playButton.centerX(inView: view)
        playButton.anchor(top: imageView.bottomAnchor, paddingTop: 34)
        
        view.addSubview(progressView)
        progressView.setDimensions(width: view.frame.size.width - 20, height: 10)
        progressView.centerX(inView: view)
        progressView.anchor(top: playButton.bottomAnchor, paddingTop: 20)
        progressView.setProgress(0, animated: false)
    }
    
    private func loadAudioFile() {
        guard let audioFilePath = Bundle.main.path(forResource: "KissTheRain", ofType: "mp3") else {
            print("Audio file not found")
            return
        }
        
        let audioFileUrl = NSURL.fileURL(withPath: audioFilePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileUrl)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback,
                                                            mode: AVAudioSession.Mode.default,
                                                            options: [AVAudioSession.CategoryOptions.mixWithOthers])
            audioPlayer.numberOfLoops = -1
        } catch {
            print ("AVAudioPlayer error = \(error)")
        }
    }
    
    private func observeAppEvent() {
        notificationCenter.publisher(for: UIApplication.didEnterBackgroundNotification).sink { [weak self] _ in
            print("Video has ended...")
            self?.audioPlayer.play()
        }.store(in: &appEventSubscribers)

        // Notification is being called when the app goes into inActive
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] (_) in
            self?.audioPlayer.pause()
        }.store(in: &appEventSubscribers)
        
        // Notification is being called when the app come back in foreground
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] (_) in
            print("Do something...")
            self?.audioPlayer.play()
        }.store(in: &appEventSubscribers)
        
    }
    
    
    private func startProgressBar() {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    private func removePlayer() {
        audioPlayer.stop()
    }
    
    // MARK: Selectors
    @objc private func didTapPlayButton() {
        isStop.toggle()
        if isStop {
            audioPlayer.play()
            startProgressBar()
            playButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        } else {
            audioPlayer.pause()
            playButton.setImage(UIImage(named: "playButton"), for: .normal)
        }
    }
    
    @objc private func updateTimer() {
        if secondsPassed < 261 {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(261)
            print(Float(secondsPassed) / Float(261))
        } else {
            timer.invalidate()
        }
    }

}
