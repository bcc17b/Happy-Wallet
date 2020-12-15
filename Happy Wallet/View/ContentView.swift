//
//  ContentView.swift
//  Happy Wallet
//
//  Created by Brady Cox on 11/23/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest( entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
                   animation: .default) var items: FetchedResults<Item>
    //Properties
    @Binding var budget: Double?
    @State private var showAddPuchase: Bool = false
    @State private var goHome: Bool = false
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
    
    public var percentage: Double {
        let total = spendable ?? 0
        let tipPercent = 0.3
        return total * tipPercent
    }
    
    private var formattedFinalTotal: String {
        currencyFormatter.string(from: NSNumber(value: percentage)) ?? "--"
    }
    
    //Body
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                summaryLine(amount: formattedFinalTotal, color: .gray)
                    
                
                Spacer()
                List{
                    ForEach(self.items, id: \.self) {items in
                        HStack{
                            Text(items.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(items.price ?? "Unknown")
                        }
                        
                    }//End list input
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle("Expenses", displayMode: .inline)
            
            .navigationBarItems(leading: Button(action:{
                self.goHome.toggle()
            }){
                Image(systemName: "")
            })//End of Button for More Puchases
            .sheet(isPresented: $goHome){
                ChartView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            
            .navigationBarItems(trailing: Button(action:{
                self.showAddPuchase.toggle()
            }){
                Image(systemName: "plus")
            })//End of Button for More Puchases
            .sheet(isPresented: $showAddPuchase){
                AddPuchase().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .padding(.horizontal)
        }//End of Navigation
    }//End of Body
    
    private func summaryLine(amount: String, color: Color) -> some View {
           Text(amount)
            .padding(10)
            .font(Font.system(size: 30, weight: .medium, design: .default))
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.blue, lineWidth: 3))
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

    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            managedObjectContext.delete(item)
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

