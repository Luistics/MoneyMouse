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

@objc(BarChartFormatter)
public class BarChartFormatter: NSObject, IAxisValueFormatter
{
    var days: [String]! = ["Test","Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        return days[Int(value)]
    }
}

//MARK- Charts Class
class ChartsPrimeViewController: UIViewController {

    //MARK- Instantiate 3 demo views of charts. The Interface builder was running into naming convention
    // problems, so I used three generic names. Doug == BarChartView.
    @IBOutlet weak var doug2: BarChartView!
    @IBOutlet weak var doug: BarChartView!
    @IBOutlet weak var doug3: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // test data
        let days = ["Monday", "Tuesday", "Wednesday", "Thursday",
                    "Friday",
                    "Saturday","Sunday"]
        let test = [50.40,10.75,14.20,40.20,11.23,23.42,12.12]
        let test2 = [24.52, 99.20, 12.32, 100.23, 210.20,40.20, 60.20]
        let test3 = [100.23, 150.20, 190.20, 50.20, 20.20, 13.20, 400.20]
        setChart(data: days, values: test)
        setFirstChart(data: days, values: test2)
        setThirdChart(data: days, values: test3)
                    // Do any additional setup after loading the view.
    }
    
    func setChart(data: [String], values:[Double]) {
        
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries : [BarChartDataEntry] = []
        
        var count = 0.0
        
        //format the axis data into readable Strings for BarChart
        for i in 0..<data.count{
            
            count+=1.0
            let entry = BarChartDataEntry(x: count, y: values[i])
            dataEntries.append(entry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Weekly Budget")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        doug.data = chartData
        doug.rightAxis.enabled = false
        doug.xAxis.drawGridLinesEnabled = false
        chartDataSet.colors = [UIColor.flatBlueColorDark(), UIColor.flatMint()]
        doug.xAxis.valueFormatter = xaxis.valueFormatter
        doug.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    //Replica setChart
    func setFirstChart(data: [String], values:[Double]) {
        
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries : [BarChartDataEntry] = []
        
        var count = 0.0
        
        for i in 0..<data.count{
            
            count+=1.0
            let entry = BarChartDataEntry(x: count, y: values[i])
            dataEntries.append(entry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "My Budget")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        doug2.data = chartData
        doug2.rightAxis.enabled = false
        doug2.xAxis.drawGridLinesEnabled = false
        chartDataSet.colors = [UIColor.flatBlueColorDark(), UIColor.flatMint()]
        doug2.xAxis.valueFormatter = xaxis.valueFormatter
        doug2.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    //Replica of setChart
    func setThirdChart(data: [String], values:[Double]) {
        
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        var dataEntries : [BarChartDataEntry] = []
        
        var count = 0.0
        
        for i in 0..<data.count{
            
            count+=1.0
            let entry = BarChartDataEntry(x: count, y: values[i])
            dataEntries.append(entry)
            formato.stringForValue(Double(i), axis: xaxis)
        }
        
        xaxis.valueFormatter = formato
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "December 2018")
        let chartData = BarChartData()
        chartData.addDataSet(chartDataSet)
        doug3.data = chartData
        doug3.rightAxis.enabled = false
        doug3.xAxis.drawGridLinesEnabled = false
        chartDataSet.colors = [UIColor.flatBlueColorDark(), UIColor.flatMint()]
        doug3.xAxis.valueFormatter = xaxis.valueFormatter
        doug3.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    //Segue into addExpenseViewController
    @IBAction func addTouched(_ sender: Any) {
        performSegue(withIdentifier: "chartsToAddExpense", sender: self)
    }
    

}
