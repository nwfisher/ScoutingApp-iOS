//
//  SVRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI

struct SVRTeamView: View {
    
    let team: SVRTeam
    @StateObject var vm = SVRTeamViewModel()
    
    var body: some View {
        var trueTeam = vm.CalledTeam
        let _ = print(vm.CalledTeam)
        ScrollView {
            VStack(alignment: .leading) {
                let i: String = String(team.team_number)
                Text(i)
                    .font(.title)
                    .bold()
                
                
                Text("**Team Name**: \(team.nickname)")
                Divider()
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                 /*if (trueTeam != nil) {
                 Group {
                 SVRrobotInformationView(team: trueTeam!)
                 }
                 Group {
                 SVRscoringLocationsView(team: trueTeam!)
                 }
                 Group {
                 SVRscoringHeightsView(team: trueTeam!)
                 SVRintakingView(team: trueTeam!)
                 }
                 Group {
                 SVRintakingLocationsView(team: trueTeam!)
                 }
                 Group {
                 SVRcycleTimeView(team: trueTeam!)
                 Divider()
                 }
                 
                 
                 NavigationLink(destination: teamMatchesView(team: team)) {
                 Text("Matches")
                 }
                 .font(.title3)
                 .foregroundColor(.blue)
                 .bold()
                 .underline()
                 
                 } else {
                 Text("No Data")
                 }*/
                 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: .infinity).ignoresSafeArea()
                    .padding()
                    .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(.horizontal, 4)
            }
            .onAppear {
                vm.getTeam(teamNumber: team.team_number)
            }
        }
    }

struct SVRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SVRTeamView(team: .init(team_number: 4255, nickname: "Robodores"))
    }
}
