//
//  RotationVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import CoreMotion

class RotationVC: UIViewController {

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
        navigationItem.title = "Rotation Test"
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Stop GyroUpdates...")
        motionManager.stopGyroUpdates()
    }
    
    // MARK: Helpers
    private func setupUI() {
        
        // imageView layouts
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        imageView.image = UIImage(named: "Rotation")
        
        // label layouts
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: imageView.bottomAnchor, paddingTop: 20)
        updateLabel(label)
        
    }
    
    private func updateLabel(_ label: UILabel) {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.5
            motionManager.startGyroUpdates(to: OperationQueue.main) { (motion, error) -> Void in
                if let trackMotion = motion {
                    let userRotation = trackMotion.rotationRate
                    let displayText = "x: \(userRotation.x) \ny: \(userRotation.y) \nz: \(userRotation.z)"
                    print(displayText)
                    DispatchQueue.main.async {
                        self.label.text = displayText
                    }
                }
            }
        }
    }


}
