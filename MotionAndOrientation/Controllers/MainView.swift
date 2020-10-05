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
    @IBOutlet var coreMotion: UIButton!
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shakeButton.layer.cornerRadius = 20
        coreMotion.layer.cornerRadius = 20
    }
    
    
    
    @IBAction func didTapShakeButton(_ sender: UIButton) {
        let vc = ShakeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapCoreMotionButton(_ sender: UIButton) {
        let vc = CoreMotionVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: Helpers
    


}

