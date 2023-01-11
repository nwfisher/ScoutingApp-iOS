//
//  MBRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI

struct MBRTeamView: View {
    
    let team: MBRTeam
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Team Number**: \(team.team_number)")
            Text("**Name**: \(team.nickname)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct MBRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MBRTeamView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
