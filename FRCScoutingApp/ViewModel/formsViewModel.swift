//
//  formsViewModel.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/17/23.
//

import Foundation

struct formsViewModel {
    
    let vm = ViewModel()
    
    func checkTeamExists(teamNumber: String) -> Bool {
        
        var a = false
        
        //Ensure MBRTeams is up to data
        vm.fetchTeams()
        
        //Iterate through teams at event
        for t in vm.MBRTeams {
            if String(t.team_number) != teamNumber {
                continue
            } else if String(t.team_number) == teamNumber {
                a = true
            } else {
                a = false
            }
        }
        
        
        //if a is true
        if a {
            return true
        } else {
            return false
        }
    }
}
