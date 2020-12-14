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
    public var budget = 750
    //Properties
    @State private var showAddPuchase: Bool = false
    @State public var spendable: Double? = 0.00
    
    private var currencyFormatter: NumberFormatter = {
        let dollars = NumberFormatter()
        // allow no currency symbol, extra digits, etc
        dollars.isLenient = true
        dollars.numberStyle = .currency
        return dollars
    }()
    
    
    //Body
    var body: some View {
        NavigationView{
            VStack{
                
                Text("$750.00")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                    .foregroundColor(.green)
                    
                
                Spacer()
                
            }
            .navigationBarTitle("Savings", displayMode: .inline)
            
        }//End of Navigation
    }//End of Body

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

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsView()
    }
}
