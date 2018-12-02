//
//  AddBudgetViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/2/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit

class AddBudgetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let budgetGoalArray = ["Travel","Transportaion", "Living" , "Other"];
    var budgetSelected = "";
    

    @IBOutlet weak var budgetPicker: UIPickerView!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var budgetAmount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
