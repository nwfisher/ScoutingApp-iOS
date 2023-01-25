//
//  MBRTeamUno.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/15/23.
//

import Foundation

struct MBRTeamUno: Decodable {
    //fetch from api
    let team_number: Int
    let nickname: String
    
    //get from scouting data
    var drivetrainType: String = ""
    var motorType: String = ""
    var programmingLanguage: String = ""
    var canPlaceLow: Bool = false
    var canPlaceMid: Bool = false
    var canPlaceHigh: Bool = false
    var canPickCone: Bool = false
    var canPickCube: Bool = false
    var canPickFallenCones: Bool = false
    var cycleTimes: String = ""
    var canPickFromGround: Bool = false
    var canPickFromShelf: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case team_number = "team_number"
        case nickname = "nickname"
        case drivetrainType = "drivetrainType"
        case motorType = "motorType"
        case programmingLanguage = "programmingLanguage"
        case canPlaceLow = "placeLow"
        case canPlaceMid = "placeMid"
        case canPlaceHigh = "placeHigh"
        case canPickCone = "intakeCone"
        case canPickCube = "intakeCube"
        case canPickFallenCones = "intakeFallenCone"
        case cycleTimes = "cycleTime"
        case canPickFromGround = "intakeFromGround"
        case canPickFromShelf = "intakeFromShelf"
    }
}
