//
//  HomepageView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/4/23.
//

import SwiftUI

struct HomepageView: View {
    
   
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .navigationTitle("Events")
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                Scouting_View()
                    .tabItem {
                        Label("Scouting", systemImage: "note.text")
                    }
                Text("Settings")
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
                
            }
            
            
        }
    }
}
            
            
        
        
        
struct HomepageView_Previews: PreviewProvider {
        static var previews: some View{
            HomepageView()
            
        }
}
        
