//
//  HomePieChart.swift
//  Happy Wallet
//
//  Created by Brady Cox on 12/10/20.
//

import Charts
import SwiftUI

struct HomeChart: UIViewRepresentable {
    var entries: [PieChartDataEntry]
    @Binding var category: Test.Category
    let pieChart = PieChartView()
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = [.systemGreen, .blue, .purple]
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        
        configureChart(uiView)
        formatCenter(uiView)
        formatDescription(uiView.chartDescription)
        formatLegend(uiView.legend)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }
    
    class Coordinator: NSObject, ChartViewDelegate{
        var parent: HomeChart
        init(parent: HomeChart){
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let labelText = entry.value(forKey: "label")! as! String
            let num = Int(entry.value(forKey: "value")! as! Double)
            parent.pieChart.centerText = """
                \(labelText)
                \(num)
                """
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func configureChart( _ pieChart: PieChartView){
        pieChart.rotationEnabled = false
        pieChart.animate(xAxisDuration:  1, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }
    
    func formatCenter( _ pieChart: PieChartView){
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerText = category.rawValue.capitalized
        pieChart.centerTextRadiusPercent = 0.95
    }
    
    func formatDescription(_ description: Description){
        description.text = "Budget"
        description.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    func formatLegend(_ legend: Legend){
        legend.enabled = false
    }
    
    func formatDataSet(_ dataSet: ChartDataSet){
        dataSet.drawValuesEnabled = false
    }
}

struct HomeChartPreviews: PreviewProvider {
    static var previews: some View{
        HomeChart(entries: Test.entriesforTest(Test.allTest, category: .variety), category: .constant(.variety))
    }
}
