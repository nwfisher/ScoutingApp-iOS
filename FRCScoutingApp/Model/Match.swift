//
//  Match.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import Foundation

struct Match: Codable {
    
    var matchID: String
    var matchNumber: String
    var selectedMatchtype: String
    var autoChargeStationComplete: String
    var autoCyclesCompleted: String
    var autoLevelsReached: String
    var telopCyclesCompleted: String //typo here, fix later
    var teamDefenseSkill: String
    var opponentDefenseSkill: String
    var opponentTeam: String
    var teamDefendedAgainst: String
    var teleopReachedL1: Bool
    var teleopReachedL2: Bool
    var teleopReachedL3: Bool
    var defended: Bool
    var teamPlayedDefense: Bool
    var notes: String
    var endgameChargeStation: String
}
