//
//  SVRTeamViewModel.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation
import Firebase

final class SVRTeamViewModel: ObservableObject {
    
    @Published var SVRTeams: [SVRTeam] = []
    
    func fetchTeams () {
        let url = URL(string: "https://www.thebluealliance.com/api/v3/event/2023casj/teams")!
        var request = URLRequest(url: url)
        
        request.addValue("eC94U6j5wAui6S7IFdgHLgxVQ4lUw2EUOm3EkzdC6VDS0Hd80efGBf5SKrPymOWa", forHTTPHeaderField: "X-TBA-Auth-Key")
        
            URLSession
                    .shared
                    .dataTask(with: request) { [weak self] data, response, error in
                        
                        DispatchQueue.main.async {
                            if error == nil {
                                
                                let decoder = JSONDecoder()
                                JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
                                
                                if let data = data,
                                let teams = try? decoder.decode ([SVRTeam].self, from: data) {
                                
                                    self?.SVRTeams = teams
                                } else {
                                    
                                }
                            }
                        }
                       
                    }.resume()
        
    }
    
    //Quick, one time function so I don't need to do work
    //This function will likley never have to be used again
    func addTeams() {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
        for team in self.SVRTeams {
            db.collection("SiliconValleyRegional").document(String(team.team_number)).setData([
                "team_number": team.team_number,
                "nickname": team.nickname
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func addPitData(teamnumber: String, drivetrainType: String, motorType: String, programmingLanguage: String, placeLow: Bool, placeMid: Bool, placeHigh: Bool, intakeCone: Bool, intakeCube: Bool, intakeFallenCone: Bool, cycleTime: String, intakeFromShelf: Bool, intakeFromGround: Bool) {
        
        FirebaseApp.configure()
        let db = Firestore.firestore()
        
       // let i = String(teamnumber)
        
        db.collection("SiliconValleyRegional").document(teamnumber).setData([
            "drivetrainType":drivetrainType,
            "motorType":motorType,
            "programmingLanguage":programmingLanguage,
            "placeLow":placeLow,
            "placeMid":placeMid,
            "placeHigh":placeHigh,
            "intakeCone":intakeCone,
            "intakeCube":intakeCube,
            "intakeFallenCone":intakeFallenCone,
            "cycleTime":cycleTime,
            "intakeFromShelf":intakeFromShelf,
            "intaleFromGround":intakeFromGround
        ], merge: true) { error in
            if error == nil {
                
            } else {
                print("Something went wrong")
            }
        }
    }
}
