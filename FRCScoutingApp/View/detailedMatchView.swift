//
//  detailedMatchView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct detailedMatchView: View {
    
    @StateObject private var vm = MBRTeamViewModel()
    let match: Match
    let team: MBRTeam

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text(String(team.team_number))
                        .font(.title)
                        .bold()
                    Text("Match: \(match.matchID)")
                    Divider()
                }
                Group {
                  AutoView(match: match)
                    teleopView(match: match)
                    endgameView(match: match)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(maxHeight: .infinity).ignoresSafeArea()
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct detailedMatchView_Previews: PreviewProvider {
    static var previews: some View {
        detailedMatchView(match: .init(matchID: "Quals0000", matchNumber: "0000", selectedMatchtype: "Quals", autoChargeStationComplete: "Maybe", autoCyclesCompleted: "Yes", autoLevelsReached: "Yes", telopCyclesCompleted: "Yes", teamDefenseSkill: "Yes", opponentDefenseSkill: "yes", opponentTeam: "Yes", teamDefendedAgainst: "yes", teleopReachedL1: false, teleopReachedL2: true, teleopReachedL3: false, defended: false, teamPlayedDefense: false, notes: "This team is trash", endgameChargeStation: "Yes"), team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true) )
    }
}
