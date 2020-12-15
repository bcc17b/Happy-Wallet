//
//  ContentView.swift
//  Happy Wallet
//
//  Created by Brady Cox on 11/23/20.
//

import SwiftUI
import CoreData

struct SavingsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest( entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
                   animation: .default) var items: FetchedResults<Item>
    //Properties
    @State private var showAddPuchase: Bool = false
    @Binding var budget: Double?
    @State var spendable: Double? = 0.00
    
    public init(budget: Binding<Double?>){
        self._budget = budget
        self._spendable = State(wrappedValue: budget.wrappedValue)
    }
    
    public var currencyFormatter: NumberFormatter = {
        let dollars = NumberFormatter()
        dollars.isLenient = true
        dollars.numberStyle = .currency
        return dollars
    }()
    
    private var percentage: Double {
        let total = spendable ?? 0
        let tipPercent = 0.2
        return total * tipPercent
    }
    
    private var formattedFinalTotal: String {
        currencyFormatter.string(from: NSNumber(value: percentage)) ?? "--"
    }
    
    
    //Body
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                HStack(alignment: .center){
                    summaryLine(amount: formattedFinalTotal, color: .gray)
                }
                
            }
            .navigationBarTitle("Savings", displayMode: .inline)
            
        }//End of Navigation
    }//End of Body
    
    private func summaryLine(amount: String, color: Color) -> some View {
           Text(amount)
            .padding(10)
            .font(Font.system(size: 30, weight: .medium, design: .default))
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.green, lineWidth: 3))
            .multilineTextAlignment(.center)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: managedObjectContext)
            newItem.timestamp = Date()

            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
