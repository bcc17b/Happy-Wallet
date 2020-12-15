//
//  AddPuchase.swift
//  Happy Wallet
//
//  Created by Brady Cox on 11/23/20.
//

import SwiftUI

struct AddPuchase: View {
    //Properties
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var price: String = ""
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    
    //Body
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    //New Purchase Name
                    TextField("Purchase", text: $name)
                    //Creation of Priorities Picker
                    TextField("Amount", text: $price)
                    
                    //Create Save Button
                    Button(action: {
                        if self.name != ""{
                            let happyWallet = Item(context: viewContext)
                            happyWallet.name = self.name
                            happyWallet.price = self.price
                            
                            do{
                                try self.viewContext.save()
                                print("New Purchase: \(happyWallet.name ?? ""), Amount: \(happyWallet.price ?? "")")
                            }catch{
                                print(error)
                            }
                        } else{
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new purchase."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                    }//End Save Button
                }//End of Form
                Spacer()
            }//End of Vstack
            .navigationBarTitle("New Puchase", displayMode: .inline)
            
            .navigationBarItems(trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName:"xmark")
            })
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("Ok")))
            }
        }//End of Navigation
    }//End of Body
}
