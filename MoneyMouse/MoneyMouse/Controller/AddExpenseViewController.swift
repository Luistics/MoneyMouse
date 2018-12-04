//
//  AddExpenseViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/4/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import Charts
import Firebase
import Foundation

class AddExpenseViewController: UIViewController {

    //Outlets to text fields on storyboard
    @IBOutlet weak var amountSpent: UITextField!
    @IBOutlet weak var budgetTitleEntered: UITextField!
    
    let userEmail = Auth.auth().currentUser?.email;
    let userID = Auth.auth().currentUser!.uid;
    let ref = Database.database().reference(withPath: "expenses")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatWhite()
        self.navigationController?.navigationBar.tintColor = UIColor.flatMint()
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
        
        //Todo: Show only the number keypad when asking for numbers in text field.
        //Todo: Give user a UIAlertController. If no is tapped, abort this function, else add to db
        //  and return to previous view controller
        
        let amountSpent = self.amountSpent?.text
        let budgetTitle = self.budgetTitleEntered?.text
        let budgetTitleLower = budgetTitle?.lowercased()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let now = df.string(from: Date())
        let expenseRef = self.ref.child(self.userID).child((budgetTitle?.lowercased())!)
        
        let ref = Database.database().reference(withPath:"budgets/" + String(userID));
        
        
        //search through the budgets database for an entry that corresponds to user input title
        ref.observe(.value, with: { snapshot in
            if snapshot.hasChild(budgetTitleLower!){
                let temp = snapshot.childSnapshot(forPath: budgetTitleLower! + "/category").value
                let expenseData = ExpenseEntry(assignedBudget: budgetTitle!, expenseAmount: Float(amountSpent!)!, category: temp as! String, addedByUser: self.userEmail!, dateEntered: now)
    
                expenseRef.setValue(expenseData.toAnyObject())
            }
            else{
                //show alert controller, that budget doesn't exist
            }
        })

    }
    
}
