//
//  AddExpenseViewController.swift
//  MoneyMouse
//
//  Created by Eisen Huang on 12/3/18.
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
        self.amountSpent.text = ""
        self.budgetTitleEntered.text = "" 

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.flatBlue()
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatMint();
        
        
        self.view.backgroundColor = UIColor.flatWhite()
        self.navigationController?.navigationBar.tintColor = UIColor.flatMint()
        
        // Do any additional setup after loading the view.
    }
    

    /*
     
 
     */
    
    @IBAction func addExpenseButtonTapped(_ sender: Any) {
    
        let amountSpent = self.amountSpent?.text
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: amountSpent ?? "0.0")
        let amountSpentFloat = number?.floatValue
        
        
        let budgetTitle = self.budgetTitleEntered?.text
        let budgetTitleLower = budgetTitle?.lowercased()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let now = df.string(from: Date())
        let expenseRef = self.ref.child(self.userID).child(budgetTitleLower!).child(now)
        let budgetsRef = Database.database().reference(withPath:"budgets/" + String(userID));
        
        
        
        //search through the budgets database for an entry that corresponds to user input title
        budgetsRef.observeSingleEvent(of:.value, with: { snapshot in
            if snapshot.hasChild(budgetTitleLower!){
                let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you want to add this expense?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Yes!", comment: "Default action"), style: .default, handler: { _ in
                    
                    let budgetToUpdate = snapshot.childSnapshot(forPath:budgetTitleLower! + "/currentAmount").value
                    let categoryOfExpense = snapshot.childSnapshot(forPath: budgetTitleLower! + "/category").value
                    let expenseData = ExpenseEntry(assignedBudget: budgetTitle!, expenseAmount: amountSpentFloat!, category: categoryOfExpense as! String, addedByUser: self.userEmail!, dateEntered: now)
                    
                    let budgetToUpdateFloat = (budgetToUpdate as AnyObject).floatValue
                    let temp = budgetToUpdateFloat! + amountSpentFloat!
                    
                    let updateRef = Database.database().reference(withPath:"budgets/" + String(self.userID) + "/" + budgetTitleLower! + "/currentAmount")
                    updateRef.setValue(temp)
                    print(temp)
                    expenseRef.setValue(expenseData.toAnyObject())
                    
                    NSLog("Expense Added")
                    self.tabBarController?.selectedIndex = 0;
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("No.", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("User tapped ok")
                        
                }))
                    
                self.present(alert, animated: true, completion: nil)
                    
                
            }
            else{
                let alert = UIAlertController(title: "Oops!", message: "You currently do not have a budget called " + budgetTitle!, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("User tapped ok")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        })

    }
    
}
