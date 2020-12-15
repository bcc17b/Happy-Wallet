//
//  ContentView.swift
//  Happy Wallet
//
//  Created by Brady Cox on 11/23/20.
//

import SwiftUI
import CoreData

struct LifeSpendigView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest( entity: Living.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Living.name, ascending: true)],
                   animation: .default) var livings: FetchedResults<Living>
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
    
    public var percentage: Double {
        let total = spendable ?? 0
        let tipPercent = 0.5
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
                    ForEach(self.livings, id: \.self) {livings in
                        HStack{
                            Text(livings.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(livings.price ?? "Unknown")
                        }
                    }//End list input
                    .onDelete(perform: deleteLivings)
                }
                
            }
            .navigationBarTitle("Expenses", displayMode: .inline)
            
            .navigationBarItems(trailing: Button(action:{
                self.showAddPuchase.toggle()
            }){
                Image(systemName: "plus")
            })//End of Button for More Puchases
            .sheet(isPresented: $showAddPuchase){
                AddPuchase().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }//End of Navigation
    }//End of Body
    
    private func summaryLine(amount: String, color: Color) -> some View {
           Text(amount)
            .padding(10)
            .font(Font.system(size: 30, weight: .medium, design: .default))
            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.purple, lineWidth: 3))
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

    private func deleteLivings(offsets: IndexSet) {
        for index in offsets {
            let living = livings[index]
            managedObjectContext.delete(living)
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


