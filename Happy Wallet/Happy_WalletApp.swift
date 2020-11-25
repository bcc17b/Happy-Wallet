//
//  Happy_WalletApp.swift
//  Happy Wallet
//
//  Created by Brady Cox on 11/23/20.
//

import SwiftUI

@main
struct Happy_WalletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct Happy_WalletApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
