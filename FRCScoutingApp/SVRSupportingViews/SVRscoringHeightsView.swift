//
//  scoringHeightsView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/11/23.
//

import SwiftUI

struct SVRscoringHeightsView: View {
    
    let team: SVRTeamUno
    
    var body: some View {
        VStack(alignment: .leading) {

            Spacer()
            .frame(maxHeight: 10)
            team.canPlaceLow ? Text("Low") : Text("")
            team.canPlaceMid ? Text("Mid") : Text("")
            team.canPlaceHigh ? Text("High") : Text("")
            
            Divider()
        }
    }
}

struct scoringHeightsView_Previews: PreviewProvider {
    static var previews: some View {
        scoringHeightsView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}