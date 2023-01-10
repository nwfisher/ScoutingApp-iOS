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
        NavigationView {
            ZStack {
                List {
                    ForEach(vm.MBRTeams, id: \.team_number) { team in
                        MBRTeamView(team: team)
                            .listRowSeparator(.hidden)
                            .searchable(text: $searchText)
                    }
                    
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                }
                .onAppear(perform: vm.fetchUsers)
            }
        }
    }
}

struct MBRView_Previews: PreviewProvider {
    static var previews: some View {
        MBRView()
    }
}
