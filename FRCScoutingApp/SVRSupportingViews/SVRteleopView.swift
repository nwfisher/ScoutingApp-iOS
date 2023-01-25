//
//  teleopView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct SVRteleopView: View {
    
    let match: Match
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("TeleOp")
                    .font(.title3)
                    .bold()
                match.defended ? Text("Team **was** defended by \(match.opponentTeam) with a \(match.opponentDefenseSkill) skill level") : Text("Team was **NOT** defended")
                Spacer()
                    .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
                Text("Cycles Completed")
                    .font(.headline)
                Text(match.telopCyclesCompleted)
                Spacer()
                    .frame(maxHeight: 10)
            }
            Group {
                Text("Levels Reached")
                    .bold()
                match.teleopReachedL1 ? Text("Low: Yes") : Text("Low: No")
                match.teleopReachedL2 ? Text("Mid: Yes") : Text("Mid: No")
                match.teleopReachedL3 ? Text("High: Yes") : Text("High: No")
                Spacer()
                    .frame(maxHeight: 10)
                
            }
            Group {
                if match.teamPlayedDefense {
                    Text("Defense")
                        .font(.headline)
                    Spacer()
                        .frame(minHeight: 10, idealHeight: 20, maxHeight: 20)
                    Text("Defended against: \(match.teamDefendedAgainst)")
                    Spacer()
                        .frame(maxHeight: 10)
                    Text("Defense skill: \(match.teamDefenseSkill)")
                }
            }
        }
    }
}

struct teleopView_Previews: PreviewProvider {
    static var previews: some View {
        teleopView(match: .init(matchID: "Quals0000", matchNumber: "0000", selectedMatchtype: "Quals", autoChargeStationComplete: "Maybe", autoCyclesCompleted: "Yes", autoLevelsReached: "Yes", telopCyclesCompleted: "Yes", teamDefenseSkill: "Yes", opponentDefenseSkill: "yes", opponentTeam: "Yes", teamDefendedAgainst: "yes", teleopReachedL1: false, teleopReachedL2: true, teleopReachedL3: false, defended: false, teamPlayedDefense: false, notes: "This team is trash", endgameChargeStation: "Yes"))
    }
}
