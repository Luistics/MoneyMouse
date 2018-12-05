//
//  ChartsPrimeViewController.swift
//  MoneyMouse
//
//  Created by Luis Olivar on 12/4/18.
//  Copyright © 2018 edu.nyu. All rights reserved.
//

import UIKit
import Charts
import Firebase

class ChartsPrimeViewController: UIViewController {

    
    @IBOutlet weak var doug2: BarChartView!
    @IBOutlet weak var doug: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let days = ["Monday", "Tuesday", "Wednesday", "Thursday",
                    "Friday",
                    "Saturday","Sunday"]
        let test = [1.0,1.0,1.5,2.0,3.0,5.0,0.0]
        setChart(data: days, values: test)
                    // Do any additional setup after loading the view.
    }
    
    func setChart(data: [String], values:[Double]){
        
        var dataEntries : [BarChartDataEntry] = []
        
        var count = 0.0
        
        for i in 0..<data.count{
            
            count+=1.0
            let entry = BarChartDataEntry(x: values[i], y: count)
            dataEntries.append(entry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Time")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        doug.data = chartData
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        doug.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        
    }
    
    func updateChartData(){
    
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
