//
//  DeviceMotionDataVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit
import CoreMotion

class StepCounterVC: UIViewController {

    // MARK: Properties
    private let activityManager = CMMotionActivityManager()
    private let pedoMeter = CMPedometer()
    
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
        label.textAlignment = .center
        label.setDimensions(width: 300, height: 30)
        return label
    }()
    
    private let counter: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setDimensions(width: 300, height: 60)
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Step Counter"
        setupUI()
        checkMotion()
        countStep()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("Stop DeviceMotionUpdates...")
    }
    
    // MARK: Helpers
    private func setupUI() {
        
        // imageView layouts
        view.addSubview(imageView)
        imageView.centerX(inView: view)
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20)
        imageView.image = UIImage(named: "counter")
        
        // label layouts
        view.addSubview(label)
        label.centerX(inView: view)
        label.anchor(top: imageView.bottomAnchor, paddingTop: 20)

        view.addSubview(counter)
        counter.centerX(inView: view)
        counter.anchor(top: label.bottomAnchor, paddingTop: 10)
        
        
    }
    
    private func checkMotion() {
        if CMMotionActivityManager.isActivityAvailable() {
            activityManager.startActivityUpdates(to: OperationQueue.main) { [weak self] (data) in
                DispatchQueue.main.async {
                    if let activity = data {
                        if activity.running == true {
                            self?.label.text = "Running"
                            print("Running")
                        } else if activity.walking == true {
                            self?.label.text = "Walking"
                            print("Walking")
                        } else if activity.automotive == true {
                            self?.label.text = "Automative"
                            print("Automative")
                        }
                    }
                }
            }
        }
    }
    
    private func countStep() {
        if CMPedometer.isStepCountingAvailable() {
            pedoMeter.startUpdates(from: Date()) { [weak self] (data, error) in
                if error == nil {
                    if let response = data {
                        DispatchQueue.main.async {
                            print("Step Counter: \(response.numberOfSteps)")
                            print("Distant: \(response.distance?.floatValue ?? 0.0)")
                            self?.counter.text = "Step Counter: \(response.numberOfSteps) \nDistance: \(response.distance?.floatValue ?? 0.0) m"
                        }
                    }
                }
            }
        }
    }
    
    

}
