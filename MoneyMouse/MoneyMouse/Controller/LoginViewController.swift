//
//  LoginViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 11/28/18.
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
       
//

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        loginButton.startAnimation()
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            
            // 3: Do your networking task or background work here.
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
                        // 4: Stop the animation, here you have three options for the `animationStyle` property:
                        // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                        // .shake: when you want to reflect to the user that the task did not complete successfly
                        // .normal
                        self.loginButton.stopAnimation(animationStyle: .expand, completion: {
                            self.performSegue(withIdentifier: "loginToHome", sender: self)
                        })
                    })
                }
            }
        })
    }
    
    
}
