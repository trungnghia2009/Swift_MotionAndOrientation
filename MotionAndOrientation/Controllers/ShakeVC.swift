//
//  ShakeVC.swift
//  MotionAndOrientation
//
//  Created by NghiaTran on 10/5/20.
//

import UIKit

class ShakeVC: UIViewController {

    // MARK: Properties
    private let label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        label.text = "Shake to change the color"
        label.textAlignment = .center
        label.textColor = .white
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .random()
        navigationItem.title = "Shake Test"
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        label.center = view.center
        
    }
    
    deinit {
        print("Do something incredible...")
    }
    
    // MARK: Helpers
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake....")
            UIDevice.vibrate()
            UIView.animate(withDuration: 0.1) {
                self.view.backgroundColor = .random()
            }
        }
    }

    

}
