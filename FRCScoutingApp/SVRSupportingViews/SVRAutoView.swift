//
//  AutoView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct SVRAutoView: View {
    
    let match: Match
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Autonomous")
                    .font(.title3)
                    .bold()
                Spacer()
                    .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
                Text("Cycles Completed")
                    .font(.headline)
                Text(match.autoCyclesCompleted)
            }
            Group {
                Spacer()
                    .frame(maxHeight: 10)
                Text("Levels reached")
                    .font(.headline)
                Text(match.autoLevelsReached)
                Spacer()
                    .frame(maxHeight: 10)
                Text("Charge Station Status")
                    .font(.headline)
                Text(match.autoChargeStationComplete)
                Divider()
            }
        }
    }
}

struct AutoView_Previews: PreviewProvider {
    static var previews: some View {
        AutoView(match: .init(matchID: "Quals0000", matchNumber: "0000", selectedMatchtype: "Quals", autoChargeStationComplete: "Maybe", autoCyclesCompleted: "Yes", autoLevelsReached: "Yes", telopCyclesCompleted: "Yes", teamDefenseSkill: "Yes", opponentDefenseSkill: "yes", opponentTeam: "Yes", teamDefendedAgainst: "yes", teleopReachedL1: false, teleopReachedL2: true, teleopReachedL3: false, defended: false, teamPlayedDefense: false, notes: "This team is trash", endgameChargeStation: "Yes"))
    }
}
