//
//  LoadingViewController.swift
//  AdmissionTest
//
//  Created by Heck Ramírez on 27/04/22.
//

import Lottie

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = AnimationView(name: "loading")
        animationView.loopMode = .loop
        animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        
        view.addSubview(animationView)
        
        animationView.play()
    }

}
