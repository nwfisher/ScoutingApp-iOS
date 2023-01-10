//
//  MBRView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/6/23.
//

import SwiftUI

struct MBRView: View {
    
    @StateObject private var vm = MBRTeamViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(vm.MBRTeams, id: \.team_number) { team in
                        NavigationLink(destination: MBRTeamView(team: team)) {
                            Text("**\(team.team_number)** \n\(team.nickname)")
                                
                        }
                        
                    }
                    
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                }
                .onAppear(perform: vm.fetchUsers)
            }
            .searchable(text: $searchText)
        }
    }
    
}

struct MBRView_Previews: PreviewProvider {
    static var previews: some View {
        MBRView()
    }
}
