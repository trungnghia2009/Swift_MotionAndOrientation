//
//  ViewController.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit

class MainView: UIViewController {

    // MARK: IBOutlet
    @IBOutlet var shakeButton: UIButton!
    @IBOutlet var accelerationButton: UIButton!
    @IBOutlet var rotationButton: UIButton!
    @IBOutlet var magneticFieldsButton: UIButton!
    @IBOutlet var deviceMotionButton: UIButton!
    @IBOutlet var audioButton: UIButton!
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shakeButton.layer.cornerRadius = 20
        accelerationButton.layer.cornerRadius = 20
        rotationButton.layer.cornerRadius = 20
        magneticFieldsButton.layer.cornerRadius = 20
        deviceMotionButton.layer.cornerRadius = 20
        audioButton.layer.cornerRadius = 20
    }
    
    
    
    @IBAction func didTapShakeButton(_ sender: UIButton) {
        let vc = ShakeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAccelerationButton(_ sender: UIButton) {
        let vc = AccelerationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapRotationButton(_ sender: UIButton) {
        let vc = RotationVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMagneticFieldsButton(_ sender: UIButton) {
        let vc = MagneticFieldsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapDeviceMotionButton(_ sender: UIButton) {
        let vc = StepCounterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapAudioButton(_ sender: UIButton) {
        let vc = AudioVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: Helpers
    


}

