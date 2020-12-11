//
//  TestData.swift
//  Happy Wallet
//
//  Created by Brady Cox on 12/10/20.
//

import Charts
import Foundation

struct Test{
    enum Category: String{
        case variety, testing
    }
    
    var category: Category
    var value: Double
    var label: String
    
    static func entriesforTest(_ tests: [Test], category: Category) -> [PieChartDataEntry]{
        let requestedTests = tests.filter{$0.category == category}
        return requestedTests.map{PieChartDataEntry(value: $0.value, label: $0.label)}
    }
    
    static var allTest: [Test]{
    [
        Test(category: .variety, value: 20, label: "Savings"),
        Test(category: .variety, value: 30, label: "Other"),
        Test(category: .variety, value: 50, label: "Living")
    ]
    }
}
