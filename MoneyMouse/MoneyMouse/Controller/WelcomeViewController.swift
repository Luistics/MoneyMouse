//
//  WelcomeViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 11/28/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import ChameleonFramework
import TransitionButton

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: TransitionButton!
    @IBOutlet weak var signUpButton: TransitionButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
        loginButton.addTarget(self, action: #selector(logInAction(_:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpAction(_:)), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInAction(_ sender: Any) {
        // 1:Login
        loginButton.startAnimation();
        // 2:Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(UInt32(0.5)) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.loginButton.stopAnimation(animationStyle: .expand, completion: {
                   self.performSegue(withIdentifier: "logIn", sender: self)
                })
            })
        })
    
    }
    @IBAction func signUpAction(_ sender: Any) {
        // 1:Login
        signUpButton.startAnimation()
        // 2:Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            sleep(UInt32(0.5)) // 3: Do your networking task or background work here.
            
            DispatchQueue.main.async(execute: { () -> Void in
                // 4: Stop the animation, here you have three options for the `animationStyle` property:
                // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                // .shake: when you want to reflect to the user that the task did not complete successfly
                // .normal
                self.signUpButton.stopAnimation(animationStyle: .expand, completion: {
                    self.performSegue(withIdentifier: "signUp", sender: self)
                })
            })
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        // If its signed in just skip the login Controllers
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
        }
    }
    
}
