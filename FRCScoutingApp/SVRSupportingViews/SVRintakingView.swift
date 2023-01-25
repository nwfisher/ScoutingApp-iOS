//
//  intakingView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/11/23.
//

import SwiftUI

struct SVRintakingView: View {
    
    let team: SVRTeamUno
    
    var body: some View {
        VStack(alignment: .leading) {
            let i: String = String(team.team_number)
            
            Group {
            Text("Intaking Game Pieces")
            .font(.title3)
            .bold()
            Text("\(i) can intake the following")
            .font(.footnote)
            Spacer()
            .frame(maxHeight: 20)
            }
            Group {
            Text("Cones")
            .font(.headline)
            team.canPickCone ? Text("Yes") : Text("No")
            
            Text("Cubes")
            .font(.headline)
            team.canPickCube ? Text("Yes") : Text("No")
            
            Text("Fallen Cones")
            .font(.headline)
            team.canPickFallenCones ? Text("Yes") : Text("No")
            Divider()
            }
        }
    }
}

struct intakingView_Previews: PreviewProvider {
    static var previews: some View {
        intakingView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
