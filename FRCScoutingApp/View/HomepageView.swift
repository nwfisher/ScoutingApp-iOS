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
            ZStack {
                Color(hex: "#144600").ignoresSafeArea()
                //dark green = 144600
                //light green = 2c9c00
                
                HStack{
                    //Profile Picture Image
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75.0)
                }
                
            }
            .frame(height:100)
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
                offlineView()
                    .tabItem {
                        Label("My Data", systemImage: "externaldrive.badge.person.crop")
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

