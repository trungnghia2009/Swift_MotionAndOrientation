//
//  DeviceMotionDataVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import CoreMotion

class DeviceMotionDataVC: UIViewController {

    // MARK: Properties
    private let motionManager = CMMotionManager()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.setDimensions(width: UIScreen.main.bounds.width - 50, height: 400)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.setDimensions(width: 300, height: 90)
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Device Motion Test"
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Stop DeviceMotionUpdates...")
        motionManager.stopDeviceMotionUpdates()
    }
    
    // MARK: Helpers
    private func setupUI() {
        
        // imageView layouts
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        imageView.image = UIImage(named: "DeviceMotionData")
        
        // label layouts
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: imageView.bottomAnchor, paddingTop: 20)
        updateLabel(label)
        
    }
    
    private func updateLabel(_ label: UILabel) {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.5
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) -> Void in
                if let trackMotion = motion {
                    let userField = trackMotion.attitude
                    let displayText = "Roll: \(userField.roll) \nPitch: \(userField.pitch) \nYaw: \(userField.yaw)"
                    print(displayText)
                    DispatchQueue.main.async {
                        self.label.text = displayText
                    }
                }
            }
        }
    }

}
