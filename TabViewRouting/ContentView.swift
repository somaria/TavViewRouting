//
//  ContentView.swift
//  TabViewRouting
//
//  Created by daryl on 11/1/24.
//

import SwiftUI
import Observation

enum AppScreen: Hashable, CaseIterable, Identifiable {
    
    case backyards
    case birds
    case plants
    
    var id: AppScreen { self }
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .backyards:
            Label("Backyards", systemImage: "tree")
        case .birds:
            Label("Birds", systemImage: "bird")
        case .plants:
            Label("Plants", systemImage: "leaf")
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .backyards:
            BackyardNavigationStack()
        case .birds:
            BirdNavigationStack()
        case .plants:
            Text("Plants")
        }
    }
    
}

struct AppTabView: View {
    
    @Binding var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection,
                content:  {
            ForEach(AppScreen.allCases) { screen in
                screen.destination.tag(screen as AppScreen?)
                    .tabItem {
                        screen.label
                    }
                
            }
        })
    }
}

enum BirdRoute: Hashable {
    case home
    case detail(String)
}

enum PlantRoute {
    case home
    case detail
}

enum BackyardRoute {
    case home
    case detail
}

struct BirdDetailScreen: View {
    
    let name: String
    
    var body: some View {
        Text(name)
    }
}

@Observable
class Router {
    var birdRoutes: [BirdRoute] = []
    var plantRoutes: [PlantRoute] = []
    var backyardRoutes: [BackyardRoute] = []
}

struct BirdNavigationStack: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        
        @Bindable var router = router
        
        NavigationStack(path: $router.birdRoutes) {
            Button("Go To Bird Detail") {
                router.birdRoutes.append(.home)
            }
            .navigationDestination(for: BirdRoute.self) { route in
                switch route {
                case .home:
                    Text("Home")
                case .detail(let name):
                    BirdDetailScreen(name: name)
                }
                
            }
        }
        
    }
}


struct BackyardNavigationStack: View {
    
    @Environment(Router.self) private var router
    
    var body: some View {
        
        @Bindable var router = router
        
        NavigationStack() {
            List(1...10, id: \.self) { index in
                
                NavigationLink {
                    Text("Backyard Detail")
                } label: {
                    Text("Backyard, \(index)")
                }
                .navigationTitle("Backyard")
            }
        }
        
    }
}


struct ContentView: View {
    
    @State private var selection:  AppScreen? = .backyards
    
    var body: some View {
        AppTabView(selection: $selection)
    }
}

#Preview {
    ContentView()
}
