//
//  pitInfo.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/15/23.
//

import Foundation

struct pitInfo: Codable {
    var teamnumber: String
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
