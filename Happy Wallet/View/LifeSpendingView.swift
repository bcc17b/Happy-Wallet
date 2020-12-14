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
                List{
                    ForEach(self.items, id: \.self) {items in
                        HStack{
                            Text(items.name ?? "Unknown")
                            
                            Spacer()
                            
                            Text(items.price ?? "Unknown")
                        }
                    }//End list input
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
        withAnimation {
            offsets.map { items[$0] }.forEach(managedObjectContext.delete)

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

struct LifeSpendigView_Previews: PreviewProvider {
    static var previews: some View {
        LifeSpendigView()
    }
}
