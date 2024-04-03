//
//  ViewController.swift
//  YourRecipes
//
//  Created by Alisina on 02.04.24.
//

import UIKit
import Lottie

class IntroViewController: UIViewController {
    
    let introImage: LottieAnimationView = {
        let iv = LottieAnimationView(animation: .named("intro-anima"))
            iv.contentMode = .scaleAspectFit
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.loopMode = .loop
            iv.animationSpeed = 0.5
        return iv
    }()
    
    let startButton: UIButton = {
       let btn = UIButton()
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.setTitle("Let's Begin", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = UIColor(named: "OliveGreen")
            btn.layer.cornerRadius = 8
            btn.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "introPage"
        viewSetup()
        
    }
    
    @objc func handleStart(){
        let controller = MainViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func viewSetup(){
        
        view.addSubview(introImage)
        view.addSubview(startButton)
        
        introImage.play()
        
        introImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        introImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        introImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        introImage.heightAnchor.constraint(equalToConstant: self.view.frame.size.height * 0.4).isActive = true
        introImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        
        startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        startButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }


}

