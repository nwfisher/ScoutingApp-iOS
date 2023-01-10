//
//  SVRView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/6/23.
//

import SwiftUI

struct SVRView: View {
    @StateObject private var vm = SVRTeamViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Create list
                List {
                    //Create a NavigationLink for each SVRTeam
                    ForEach(vm.SVRTeams, id: \.team_number) { team in
                        
                            NavigationLink(destination: SVRTeamView(team: team)) {
                                Text("**\(team.team_number)** \n\(team.nickname)")
                            }
                                
                        }
                        
                    }
                    
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                }
                .onAppear(perform: vm.fetchUsers)
            }
    //Search function is non-functional
        .searchable(text: $searchText, prompt: "Seach by Team number")
    }
}

struct SVRView_Previews: PreviewProvider {
    static var previews: some View {
        SVRView()
    }
}
