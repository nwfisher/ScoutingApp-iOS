//
//  SwiftUIView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/28/23.
//

import SwiftUI

struct intakeLocations: View {
    let team: completeTeam
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
            
            team.intakeFromSingle ? Text("Single Substation") : Text("")
            team.intakeFromDouble ? Text("Double Substation") : Text("")
            team.intakeFromGround ? Text("Ground") : Text("")
            Divider()
        }
    }
}

struct intakeLocations_Previews: PreviewProvider {
    static var previews: some View {
        intakeLocations(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", intakeFromGround: true, intakeFromSingle: true, intakeFromDouble: true))
    }
}
