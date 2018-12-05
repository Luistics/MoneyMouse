//
//  HomeTableViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/3/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Charts
import ChameleonFramework

class BudgetProgressTableViewCell: UITableViewCell{
    
    @IBOutlet weak var budgetTotalAmount: UILabel!
    @IBOutlet weak var budgetTitle: UILabel!
    @IBOutlet weak var budgetProgress: UIProgressView!
    @IBOutlet weak var budgetCurrentAmount: UILabel!
    @IBOutlet weak var budgetRemaining: UILabel!
}


class HomeTableViewController: UITableViewController {

    var testBudgets = [BudgetGoal]()
    let cellSpacingHeight : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatBlue()

        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let userID = Auth.auth().currentUser!.uid;
        
        
        let ref = Database.database().reference(withPath:"budgets/" + String(userID));
        
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
        
        
//        let budgetGoal = BudgetGoal(title:"Test Budget!",
//                                    totalAmount: 100,
//                                    currentAmount: 20,
//                                    category: "Travel",
//                                    addedByUser: "lao294@nyu.edu",
//                                    completed: false)
//
//        let budgetGoal1 = BudgetGoal(title:"Test Budget 2!",
//                                    totalAmount: 20,
//                                    currentAmount: 3,
//                                    category: "Entertainment",
//                                    addedByUser: "lao@nyu.edu",
//                                    completed: false)
//
//        testBudgets = [budgetGoal, budgetGoal1]

    }
    
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetProgressCell", for: indexPath) as! BudgetProgressTableViewCell
        
        cell.budgetTitle?.text = testBudgets[indexPath.section].title
        
        let totalAmount = testBudgets[indexPath.section].totalAmount
        
        cell.budgetTotalAmount?.text = "$" + String(format: "%.2f",totalAmount)
        
        let currentAmount = testBudgets[indexPath.section].currentAmount
        
        cell.budgetCurrentAmount?.text = "$" + String(format: "%.2f",currentAmount)
        
        let progress = currentAmount/totalAmount
        
        let remaining = totalAmount - currentAmount
        
        cell.budgetRemaining?.text = "$" + String(format: "%.2f",remaining)
        
        if(progress > 0.90){
            cell.budgetProgress.progressTintColor = UIColor.flatRed()
        }
        
        if(progress > 0.75 && progress < 0.90){
            cell.budgetProgress.progressTintColor = UIColor.flatYellow()
        }
        
        cell.budgetProgress.setProgress(progress, animated: true)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let budgetGoal = testBudgets[indexPath.section]
            budgetGoal.ref?.removeValue()
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

    //IBAction functions for button presses
    
    @IBAction func addBudgetTapped(_ sender: Any) {
        performSegue(withIdentifier: "addBudgetGoal", sender: self)
    }
    
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
