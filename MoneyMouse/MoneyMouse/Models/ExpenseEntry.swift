//
//  ExpenseEntry.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/4/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import Foundation
import FirebaseDatabase

//defines a model for an expense entry
/*
    Ideally uses addedbyuserid to fetch all those that
    match the current user's id, but current
    implementation uses user email and lets
    FireBaseAuth take care of duplicate email
    registrations
 */

struct ExpenseEntry {
    
    //Dates are stored as Swift Date format, which Firebase understands.
    //When imported as Data into charts, all the data is imported into the chart at once.
    let ref: DatabaseReference?
    let key: String
    let addedByUser: String
    let category: String
    let expenseAmount: Float
    let dateEntered: String
    let assignedBudget: String
    
    init(assignedBudget: String, expenseAmount: Float, category: String, addedByUser: String, dateEntered: String, key: String = ""){
        self.ref = nil
        self.key = key
        self.addedByUser = addedByUser
        self.category = category
        self.expenseAmount = expenseAmount
        self.dateEntered = dateEntered
        self.assignedBudget = assignedBudget
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let addedByUser = value["addedByUser"] as? String,
            let category = value["category"] as? String,
            let expenseAmount = value["expenseAmount"] as? Float,
            let assignedBudget = value["assignedBudget"] as? String,
            let dateEntered = value["dateEntered"] as? String else{
                return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.addedByUser = addedByUser
        self.category = category
        self.expenseAmount = expenseAmount
        self.dateEntered = dateEntered
        self.assignedBudget = assignedBudget
    }
    
    func toAnyObject() -> Any {
        return [
            "assignedBudget": assignedBudget,
            "expenseAmount": expenseAmount,
            "addedByUser": addedByUser,
            "category": category,
            "dateEntered": dateEntered
        ]
    }
}
