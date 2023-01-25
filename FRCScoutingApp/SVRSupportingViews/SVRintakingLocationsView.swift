//
//  intakingLocationsView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/11/23.
//

import SwiftUI

struct SVRintakingLocationsView: View {
    
    let team: SVRTeamUno
    var body: some View {
        VStack(alignment: .leading) {
            let i: String = String(team.team_number)
            
            Text("Intaking Locations")
                .font(.title3)
                .bold()
            Text("\(i) can intake at the following locations")
                .font(.footnote)
            Spacer()
                .frame(maxHeight: 20)
            
            team.canPickFromShelf ? Text("Shelf") : Text("")
            team.canPickFromGround ? Text("Ground") : Text("")
            Divider()
        }
    }
}

struct intakingLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        intakingLocationsView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
