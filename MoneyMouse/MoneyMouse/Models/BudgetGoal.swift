//
//  BudgetGoal.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/2/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct BudgetGoal {
    
    let ref: DatabaseReference?
    let key: String
    let addedByUser: String
    var completed: Bool
    let category: String
    let totalAmount: Float
    let currentAmount: Float
    let title: String
    
    init(title: String, totalAmount: Float, currentAmount: Float, category: String, addedByUser: String, completed: Bool, key: String = ""){
        self.ref = nil
        self.key = key
        self.addedByUser = addedByUser
        self.completed = completed
        self.totalAmount = totalAmount
        self.currentAmount = currentAmount
        self.category = category
        self.title = title
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let addedByUser = value["addedByUser"] as? String,
            let category = value["category"] as? String,
            let totalAmount = value["totalAmount"] as? Float,
            let title = value["title"] as? String,
            let currentAmount = value["currentAmount"] as? Float,
            let completed = value["completed"] as? Bool else{
            return nil
        }
        
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.addedByUser = addedByUser
        self.completed = completed
        self.category = category
        self.totalAmount = totalAmount
        self.currentAmount = currentAmount
        self.title = title
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "addedByUser": addedByUser,
            "completed": completed,
            "category": category,
            "totalAmount": totalAmount,
            "currentAmount": currentAmount
        ]
    }
}
