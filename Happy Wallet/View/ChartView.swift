//
//  ChartView.swift
//  Happy Wallet
//
//  Created by Brady Cox on 12/11/20.
//

import Charts
import SwiftUI

struct ChartView: View {
    @State private var pieChartEntries: [PieChartDataEntry] = []
    @State private var category: Test.Category = .variety
    var body: some View {
        VStack{
            HomeChart(entries: Test.entriesforTest(Test.allTest, category: category),
                     category: $category)
                .frame(height: 400)
        }
        .padding(.horizontal)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
