//
//  MBRTeam.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation

struct MBRTeam: Decodable {
    //fetch from api
    let team_number: Int
    let nickname: String
    
    //get from scouting data
    var drivetrainType: String
    var motorType: String
    var programmingLanguage: String
    var canPlaceLow: Bool
    var canPlaceMid: Bool
    var canPlaceHigh: Bool
    var canPickCone: Bool
    var canPickCube: Bool
    var canPickFallenCones: Bool
    var cycleTimes: String
    var canPickFromGround: Bool
    var canPickFromShelf: Bool
    
}
