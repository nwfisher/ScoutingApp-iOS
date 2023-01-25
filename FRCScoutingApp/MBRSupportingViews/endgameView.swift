//
//  endgameView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct endgameView: View {
    
    let match: Match
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            Text("Endgame")
                .font(.title3)
                .bold()
            Spacer()
                .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
            Group {
                Text("Charge Station Status")
                    .font(.headline)
                Spacer()
                    .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
                Text(match.endgameChargeStation)
                Spacer()
                    .frame(maxHeight: 10)
                Text("Notes")
                    .font(.headline)
                Spacer()
                    .frame(maxHeight: 10)
                Text(match.notes)
            }
        }
    }
}

struct endgameView_Previews: PreviewProvider {
    static var previews: some View {
        endgameView(match: .init(matchID: "Quals0000", matchNumber: "0000", selectedMatchtype: "Quals", autoChargeStationComplete: "Maybe", autoCyclesCompleted: "Yes", autoLevelsReached: "Yes", telopCyclesCompleted: "Yes", teamDefenseSkill: "Yes", opponentDefenseSkill: "yes", opponentTeam: "Yes", teamDefendedAgainst: "yes", teleopReachedL1: false, teleopReachedL2: true, teleopReachedL3: false, defended: false, teamPlayedDefense: false, notes: "This team is trash", endgameChargeStation: "Yes"))
    }
}
