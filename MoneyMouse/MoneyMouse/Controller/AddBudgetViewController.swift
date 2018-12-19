//
//  AddBudgetViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar, Eisen Huang, Tom Fogle on 12/2/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import TransitionButton

class AddBudgetViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let budgetGoalArray = ["Travel","Transportation", "Living" , "Entertainment", "Other"];
    var budgetSelected = "";
    

    @IBOutlet weak var budgetPicker: UIPickerView!
    @IBOutlet weak var budgetTitle: UITextField!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var addBudgetButton: TransitionButton!
    

    let ref = Database.database().reference(withPath: "budgets")
    let userEmail = Auth.auth().currentUser?.email;
    let userID = Auth.auth().currentUser!.uid;
    
    @IBOutlet weak var budgetAmount: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.flatMint();
        addBudgetButton.spinnerColor = .white
        addBudgetButton.addTarget(self, action: #selector(addBudgetPressed(_:)), for: .touchUpInside)
        
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
    
    //Setup for the picker view for categories.
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
        
        //Guard the amount to cast into a Float.
        let budgetTitle = self.budgetTitle.text
        guard let text = self.budgetAmount.text, let number = Float(text) else {
            return
        }
        
        //MARK- Error Check for negative numbers
        if(number <= Float(0.0)){
            let alert = UIAlertController(title: "Oops!", message: "You entered a negative number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("User tapped ok")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            //get the snapshot of the database to check if the budget entered already exists.
            let testSnapshot = self.ref.child(self.userID)
            testSnapshot.observeSingleEvent(of:.value, with: { snapshot in
                
                //if the budget exists, let the user know, and exit the action.
                if(snapshot.hasChild(budgetTitle!.lowercased())){
                    self.addBudgetButton.startAnimation()
                    let alert = UIAlertController(title: "Oops!", message: "That budget already exists.", preferredStyle: .alert)
                    self.addBudgetButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 1, completion: nil)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("User tapped ok")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                    
                    //if the budget did not exist, ask user if they are sure. Add if so.
                else{
                    
                    let alert = UIAlertController(title: "New Budget!", message: "Are you sure you want to add this budget goal?", preferredStyle: .alert)
                    
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Yes!", comment: "Add to db, segue into home."), style: .default, handler: { _ in
                        //MARK- Start Animation
                        self.addBudgetButton.startAnimation()
                        
                        //Create a new BudgetGoal object
                        let budgetGoal = BudgetGoal(title:budgetTitle!,
                                                    totalAmount: number,
                                                    currentAmount: 0,
                                                    category: self.budgetLabel.text!,
                                                    addedByUser: self.userEmail!,
                                                    completed: false)
                        
                        //Add this new object to the database.
                        let budgetRef = self.ref.child(self.userID).child(budgetTitle!.lowercased())
                        budgetRef.setValue(budgetGoal.toAnyObject())
                        
                        
                        let qualityOfServiceClass = DispatchQoS.QoSClass.background
                        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
                        backgroundQueue.async(execute: {
                            //Create a queue and stop animation after the background work
                            DispatchQueue.main.async(execute: { () -> Void in
                                // 4: Stop the animation
                                self.addBudgetButton.stopAnimation(animationStyle: .expand, completion: {
                                    self.navigationController?.popViewController(animated: true)
                                })
                            })
                        })
                    }))
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("No.", comment: "Default action"), style: .default, handler: { _ in
                        NSLog("The \"OK\" alert occured.")
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
            })
        }
        
        
       
       
    }
    //MARK- Update Data
    func UpdateData(){
        budgetLabel.text = budgetSelected;
    }

}
