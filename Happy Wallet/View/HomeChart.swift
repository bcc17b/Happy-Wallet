//
//  HomeChart.swift
//  Happy Wallet
//
//  Created by Brady Cox on 12/10/20.
//

import Charts
import SwiftUI

struct HomeChart: View {
    let entries: [PieChartDataEntry]
    func makeUIView(context: Context) -> PieChartView{
        return PieChartView()
    }
    
    func updateUIView(uiView: PieChartView, context: Context){
        let dataSet = PieChartDataSet(entries: entries)
        uiView.data = PieChartData(dataSet: dataSet)
    }
    var chartView: PieChartView!
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeChart_Previews: PreviewProvider {
    static var previews: some View {
        HomeChart(entries: [PieChartDataEntry])
    }
}
