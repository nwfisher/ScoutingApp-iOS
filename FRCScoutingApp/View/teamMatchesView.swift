//
//  teamMatchesView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct teamMatchesView: View {
    
   @StateObject var vm = MBRTeamViewModel()
    let team: MBRTeam
    
    var body: some View {
        NavigationStack {
           List {
               ForEach(vm.Matches, id: \.matchID) { match in
                   NavigationLink(destination: detailedMatchView(match: match, team: team)) {
                       
                       Text("**\(match.matchID)**")
                   }
               }
            }
        }
        .navigationTitle("\(String(team.team_number))'s Match Data")
        .onAppear {
            vm.fetchMatchData(teamNumber: team.team_number)
        }
    }
}

struct teamMatchesView_Previews: PreviewProvider {
    static var previews: some View {
        teamMatchesView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
