//
//  AddEntryViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/2/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController {

    @IBOutlet weak var budgetGoalButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapBudgetButton(_ sender: Any) {
        performSegue(withIdentifier: "addBudgetGoal", sender: self)
    }
    
    @IBAction func didTapExpenseButton(_ sender: Any) {
        performSegue(withIdentifier: "addExpense", sender: self)
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
