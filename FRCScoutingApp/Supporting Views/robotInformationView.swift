//
//  robotInformationView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/11/23.
//

import SwiftUI

struct robotInformationView: View {
    
    let team: MBRTeamUno
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Robot Information")
                .font(.title3)
                .bold()
    
        Spacer()
            .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
        Text("Drivetrain")
            .font(.headline)
        Text(team.drivetrainType)
        Spacer()
            .frame(maxHeight: 10)
        Text("Motor Type")
            .font(.headline)
        Text(team.motorType)
        Spacer()
            .frame(maxHeight: 10)
        Text("Programming Language")
            .font(.headline)
        Text(team.programmingLanguage)
    }
    }
}

struct robotInformationView_Previews: PreviewProvider {
    static var previews: some View {
        robotInformationView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
