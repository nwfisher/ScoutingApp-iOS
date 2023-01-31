//
//  MBRView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/6/23.
//

import SwiftUI

struct MBRView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Create list
                List {
                    //Sort teams by asending team number
                    let sortedTeams = vm.MBRTeams.sorted(by: { $0.team_number < $1.team_number })
                    //Create a NavigationLink for each MBRTeam
                    ForEach(sortedTeams, id: \.team_number) { team in
                        
                            NavigationLink(destination: MBRTeamView(team: team)) {
                                
                                let i = String(team.team_number)
                                
                                Text("**\(i)** \n\(team.nickname)")
                            }
                                
                        }
                        
                    }
                    
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                }
                .onAppear(perform: vm.fetchTeams)
            }
    //Search function is non-functional
        .searchable(text: $searchText, prompt: "Seach by Team number")
    }
    
}

struct MBRView_Previews: PreviewProvider {
    static var previews: some View {
        MBRView()
    }
}
