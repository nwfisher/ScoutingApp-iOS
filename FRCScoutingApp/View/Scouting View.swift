//
//  Scouting View.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/5/23.
//

import SwiftUI

struct Scouting_View: View {
    var body: some View {
        ZStack {
            NavigationStack {
                NavigationLink(destination: pitScoutingForm()) {
                    Text("Pit Scouting")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, alignment: .center)
                        .frame(height: 200)
                        .background(Color(hex: "#144600"))
                        .cornerRadius(10)
                    
                }
                
                NavigationLink(destination: pitScoutingForm()) {
                    Text("Field Scouting")
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 350, alignment: .center)
                        .frame(height: 200)
                        .background(Color(hex: "#fdda24"))
                        .navigationTitle("Scouting")
                        .cornerRadius(10)
                }
             
            }
        }
        
    }
}

struct Scouting_View_Previews: PreviewProvider {
    static var previews: some View {
        Scouting_View()
    }
}
