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
                Color(hex: "#2c9c00").ignoresSafeArea()
                
                HStack{
                    //Profile Picture Image
                    Image( "6623BA4C-73C7-444C-AA45-2B402A36904A_1_105_c")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75.0)
                        .clipShape(Circle())
                        .padding(.leading)
                    
                    //Welcome User
                    Text("Welcome, Nick!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(0.0)
                        .foregroundColor(Color(hex: "#FDDA24"))
                        
                    
                    
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
        
