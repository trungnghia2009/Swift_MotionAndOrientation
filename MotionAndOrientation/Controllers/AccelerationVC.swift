//
//  CoreMotionVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import CoreMotion

class AccelerationVC: UIViewController {

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
        navigationItem.title = "Acceleration Test"
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Stop AccelerometerUpdates...")
        motionManager.stopAccelerometerUpdates()
    }
    
    // MARK: Helpers
    private func setupUI() {
        
        // imageView layouts
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        imageView.image = UIImage(named: "Acceleration")
        
        // label layouts
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: imageView.bottomAnchor, paddingTop: 20)
        updateLabel(label)
        
    }
    
    private func updateLabel(_ label: UILabel) {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.5
            motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (motion, error) -> Void in
                if let trackMotion = motion {
                    let userAcceleration = trackMotion.acceleration
                    let displayText = "x: \(userAcceleration.x) \ny: \(userAcceleration.y) \nz: \(userAcceleration.z)"
                    print(displayText)
                    DispatchQueue.main.async {
                        self.label.text = displayText
                    }
                }
            }
        }
    }

}
