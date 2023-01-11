//
//  SVRTeam.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation

struct SVRTeam: Decodable {
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
    }
}
