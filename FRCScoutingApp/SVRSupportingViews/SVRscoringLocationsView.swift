//
//  scoringLocationsView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/11/23.
//

import SwiftUI

struct SVRscoringLocationsView: View {
    
    let team: SVRTeamUno

    
    var body: some View {
        VStack(alignment: .leading) {
            
            let i: String = String(team.team_number)
            
            Divider()
            Text("Scoring Locations")
                .font(.title3)
                .bold()
            Text("\(i) can score at the following heights")
                .font(.footnote)
        }
    }
}

struct scoringLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        scoringLocationsView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
