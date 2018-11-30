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

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInAction(_ sender: Any) {
        performSegue(withIdentifier: "logIn", sender: self)
    }
    @IBAction func signUpAction(_ sender: Any) {
        performSegue(withIdentifier: "signUp", sender: self)
    }
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alreadyLoggedIn", sender: nil)
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
