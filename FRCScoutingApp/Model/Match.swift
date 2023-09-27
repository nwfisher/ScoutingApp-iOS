//
//  Match.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import Foundation

struct Match: Codable, Hashable {
    
    var teamNumber: String
    var matchID: String
    var matchNumber: String
    var matchType: String
    //Auto scoring
    var autoLowCube: Int
    var autoMidCube: Int
    var autoHighCube: Int
    var autoLowCone: Int
    var autoMidCone: Int
    var autoHighCone: Int
    //Teleop scoring
    var teleopLowCube: Int
    var teleopMidCube: Int
    var teleopHighCube: Int
    var teleopLowCone: Int
    var teleopMidCone: Int
    var teleopHighCone: Int
    //Charge Station
    var autoChargeStationPts: Int
    var endgame: String
    var notes: String
}
