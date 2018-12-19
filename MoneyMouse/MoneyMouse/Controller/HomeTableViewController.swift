//
//  HomeTableViewController.swift
//  MoneyMouse
//
// Created by Luis Olivar on 12/3/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Charts
import ChameleonFramework
import SwipeCellKit

//MARK- TableViewCell class for templating cells in the table view
class BudgetProgressTableViewCell: UITableViewCell{
    
    @IBOutlet weak var budgetTotalAmount: UILabel!
    @IBOutlet weak var budgetTitle: UILabel!
    @IBOutlet weak var budgetProgress: UIProgressView!
    @IBOutlet weak var budgetCurrentAmount: UILabel!
    @IBOutlet weak var budgetRemaining: UILabel!
}


class HomeTableViewController: UITableViewController {

    //define table properties
    var testBudgets = [BudgetGoal]()
    let cellSpacingHeight : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let userID = Auth.auth().currentUser!.uid;
        
        
        let ref = Database.database().reference(withPath:"budgets/" + String(userID));
        //MARK- Observe data in Firebase and add into an array of BudgetGoals. Load the tableview with this found data.
        ref.observe(.value, with: { snapshot in
            var newItems: [BudgetGoal] = []
            
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let budgetGoal = BudgetGoal(snapshot: snapshot) {
                    newItems.append(budgetGoal)
                }
            }
            
            self.testBudgets = newItems
            self.tableView.reloadData()
        })

    }
    
    //MARK- Format dates incoming from Database.
    func stripTime(from originalDate: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: originalDate)
        let date = Calendar.current.date(from: components)
        return date!
    }

    // MARK: - Table view data source, all functions for table view

    //define the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return testBudgets.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return cellSpacingHeight
    }
    
    
    //Define the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    //Define the way that the cells are filled, given data from the Database.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetProgressCell", for: indexPath) as! BudgetProgressTableViewCell
        
        cell.budgetTitle?.text = testBudgets[indexPath.section].title
        
        let totalAmount = testBudgets[indexPath.section].totalAmount
        
        cell.budgetTotalAmount?.text = "Total: $" + String(format: "%.2f",totalAmount)
        
        let currentAmount = testBudgets[indexPath.section].currentAmount
        
        cell.budgetCurrentAmount?.text = "Spent: $" + String(format: "%.2f",currentAmount)
        
        let progress = currentAmount/totalAmount
        
        let remaining = totalAmount - currentAmount
        
        cell.budgetRemaining?.text = "Left: $" + String(format: "%.2f",remaining)
        
        //print(progress)
        
        //Define colors for different progress states.
        if(progress >= 0.75 && progress <= 0.90){
            cell.budgetProgress.progressTintColor = UIColor.flatYellow()
        }
        else if(progress > 0.90){
            cell.budgetProgress.progressTintColor = UIColor.flatRed()
        }
        
        cell.budgetProgress.setProgress(progress, animated: true)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Swipe to delete a budget.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let budgetGoal = testBudgets[indexPath.section]
            budgetGoal.ref?.removeValue()
        }
    }
    
    //IBAction functions for button presses
    
    @IBAction func addBudgetTapped(_ sender: Any) {
        performSegue(withIdentifier: "addBudgetGoal", sender: self)
    }
    //MARK- Sign Out
    @IBAction func signOutAction(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }

}
