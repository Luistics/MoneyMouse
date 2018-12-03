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

class BudgetProgressTableViewCell: UITableViewCell{
    
    @IBOutlet weak var budgetTotalAmount: UILabel!
    @IBOutlet weak var budgetTitle: UILabel!
    @IBOutlet weak var budgetProgress: UIProgressView!
    
}


class HomeTableViewController: UITableViewController {

    
    var testBudgets = [BudgetGoal]()
    let cellSpacingHeight : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let userID = Auth.auth().currentUser!.uid;
        
        let ref = Database.database().reference(withPath:userID);
        
        let budgetGoal = BudgetGoal(title:"Test Budget!",
                                    amount: 100,
                                    category: "Travel",
                                    addedByUser: "lao294@nyu.edu",
                                    completed: false)
        
        let budgetGoal1 = BudgetGoal(title:"Test Budget 2!",
                                    amount: 20,
                                    category: "Entertainment",
                                    addedByUser: "lao@nyu.edu",
                                    completed: false)
        
        testBudgets = [budgetGoal, budgetGoal1]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return testBudgets.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetProgressCell", for: indexPath) as! BudgetProgressTableViewCell
        
        cell.budgetTitle?.text = testBudgets[indexPath.section].title
        // Configure the cell...

        return cell
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
