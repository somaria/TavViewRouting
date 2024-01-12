//
//  TabViewRoutingApp.swift
//  TabViewRouting
//
//  Created by daryl on 11/1/24.
//

import SwiftUI

@main
struct TabViewRoutingApp: App {
    
    @State private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(router)
        }
    }
}
