//
//  AddBudgetViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/2/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AddBudgetViewController: UIViewController {

    let ref = Database.database().reference(withPath: "budgets")
    let userEmail = Auth.auth().currentUser?.email;
    
    @IBOutlet weak var typeOfBudget: UITextField!
    @IBOutlet weak var budgetAmount: UITextField!
    //titleOfBudget
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBudgetPressed(_ sender: Any) {
        
        guard let text = budgetAmount.text, let number = Float(text) else {
            return
        }
        let budgetGoal = BudgetGoal(amount: number,
                                    title:"BudgetTest",
                                    category: typeOfBudget.text!,
                                    addedByUser: self.userEmail!,
                                    completed: false)
        
        self.ref.setValue(budgetGoal.toAnyObject())
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
