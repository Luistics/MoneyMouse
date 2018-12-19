//
//  LoginViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar, Eisen Huang, Tom Fogle on 11/28/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import TransitionButton


class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: TransitionButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginButton)
        
        
        loginButton.layer.cornerRadius = 20;
        loginButton.spinnerColor = .white
        loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
    }
    
//MARK- Login
    @IBAction func loginAction(_ sender: Any) {
        //Start the Animation
        loginButton.startAnimation()
        
        // 1: Make a queue to hold processes, then when it's empty, stop animation.
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        // 2: Dispatch queue
        backgroundQueue.async(execute: {
            
            // 3: Do the networking task or background work here.
            Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                if error != nil{
                    self.loginButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: nil)
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    alertController.view.layoutIfNeeded()
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                else{
                    DispatchQueue.main.async(execute: { () -> Void in
                        // 4: Stop the animation here
                        self.loginButton.stopAnimation(animationStyle: .expand, completion: {
                            // 5: segue into home controller
                            self.performSegue(withIdentifier: "loginToHome", sender: self)
                        })
                    })
                }
            }
        })
    }
    
    
}
