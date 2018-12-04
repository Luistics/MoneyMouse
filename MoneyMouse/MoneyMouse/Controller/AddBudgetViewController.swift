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

class AddBudgetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let budgetGoalArray = ["Travel","Transportation", "Living" , "Entertainment", "Other"];
    var budgetSelected = "";
    

    @IBOutlet weak var budgetPicker: UIPickerView!
    @IBOutlet weak var budgetTitle: UITextField!
    @IBOutlet weak var budgetLabel: UILabel!

    let ref = Database.database().reference(withPath: "budgets")
    let userEmail = Auth.auth().currentUser?.email;
    let userID = Auth.auth().currentUser!.uid;
    
    @IBOutlet weak var budgetAmount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.view.backgroundColor = UIColor.flatBlue()
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatMint();
        
        /*
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
        */
        // Do any additional setup after loading the view.
        budgetPicker.delegate = self;
        budgetPicker.dataSource = self;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return budgetGoalArray.count;
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return budgetGoalArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(budgetGoalArray[row])
        budgetSelected = budgetGoalArray[row]
        UpdateData()
    }
    
    @IBAction func addBudgetPressed(_ sender: Any) {
        
        //Todo: Add alert controller to ask user if they are sure, if yes,
        //then segue into the home view.
        
        
        guard let text = budgetAmount.text, let number = Float(text) else {
            return
        }
        
        let budgetTitle = self.budgetTitle.text
        
        let budgetGoal = BudgetGoal(title:budgetTitle!,
                                    totalAmount: number,
                                    currentAmount: 0,
                                    category: budgetLabel.text!,
                                    addedByUser: self.userEmail!,
                                    completed: false)
        
        let budgetRef = self.ref.child(self.userID).child(budgetTitle!.lowercased())
        
        budgetRef.setValue(budgetGoal.toAnyObject())
    }
    
    func UpdateData(){
        budgetLabel.text = budgetSelected;
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
