//
//  RegisterViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 11/28/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import TransitionButton

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var registerButton: TransitionButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.flatBlue()
        passwordField.layer.cornerRadius = 40
        passwordField.layer.cornerRadius = 40
        email.layer.cornerRadius = 40
        registerButton.layer.cornerRadius = 20
        registerButton.spinnerColor = .white
        registerButton.addTarget(self, action: #selector(signUpAction(_:)), for: .touchUpInside)
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        if passwordField.text != passwordCheckField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            alertController.view.layoutIfNeeded()
            self.present(alertController, animated: true, completion: nil)
        }
        
        else{
            Auth.auth().createUser(withEmail: email.text!, password: passwordField.text!){ (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signUpToHome", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    alertController.view.layoutIfNeeded() 
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
