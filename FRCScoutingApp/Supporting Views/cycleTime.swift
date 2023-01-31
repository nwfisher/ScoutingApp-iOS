//
//  cycleTime.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/28/23.
//

import SwiftUI

struct cycleTime: View {
   
    let team: completeTeam
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cycle Time")
            .font(.title3)
            .bold()
            Spacer()
            .frame(maxHeight: 20)
            Text(team.cycleTimes)
        }
    }
}

struct cycleTime_Previews: PreviewProvider {
    static var previews: some View {
        cycleTime(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
