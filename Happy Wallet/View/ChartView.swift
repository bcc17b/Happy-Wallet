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
    @State private var budget: Double? = 0.00
    
    private var currencyFormatter: NumberFormatter = {
        let dollars = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        dollars.isLenient = true
        dollars.numberStyle = .currency
        return dollars
    }()
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Budget")
                    .font(Font.system(size: 50, weight: .bold, design: .default))
                    .padding()
                TextField("Income", value: $budget, formatter: currencyFormatter)
                    .padding(10)
                    .font(Font.system(size: 30, weight: .medium, design: .default))
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.green, lineWidth: 3))
                    .multilineTextAlignment(.center)
            
                VStack {
                    HomeChart(entries: Test.entriesforTest(Test.allTest, category: category),
                         category: $category)
                        .frame(height: 400)
                }
                HStack{
                    NavigationLink(
                        destination: SavingsView(),
                        label: {
                            Text("Savings")
                                .font(Font.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .background(Color.green)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.green, lineWidth: 2))
                        })
                        .padding()
                    
                    NavigationLink(
                        destination: LifeSpendigView(),
                        label: {
                            Text("Living")
                                .font(Font.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .background(Color.purple)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.purple, lineWidth: 2))
                        })
                        .padding()
                    NavigationLink(
                        destination: ContentView(),
                        label: {
                            Text("Other")
                                .font(Font.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.blue, lineWidth: 2))
                        })
                        .padding()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(Color.green)
            .cornerRadius(8)
    }
}
