//
//  ChartsViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/4/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import Firebase
import Charts

class ChartsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //ToDo make charts based on imported data
    
    /*
        Charts are rendered through taking the data from the expenseDB, which is then parsed here
        and sorted through by date. These charts show the most recent expenses from the previous month
        in the form of a line bar graph.
    */
    
    @IBAction func addExpenseTapped(_ sender: Any) {
        performSegue(withIdentifier: "chartsToAddExpense", sender: self)
    }
    
}
