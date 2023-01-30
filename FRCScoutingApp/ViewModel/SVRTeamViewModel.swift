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
    @Published var CalledTeam: SVRTeamUno?
    @Published var Matches: [Match] = []
    
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
    
    func addMatchData(teamNumber: String, matchNumber: String, matchType: String, autoLowCube: Int, autoMidCube: Int, autoHighCube: Int, autoLowCone: Int, autoMidCone: Int, autoHighCone: Int, teleopLowCube: Int, teleopMidCube: Int, teleopHighCube: Int, teleopLowCone: Int, teleopMidCone: Int, teleopHighCone: Int, autoChargeStation: String, teleopChargeStation: String) {
        
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
        let documentID = matchType + matchNumber
        
        db.collection("SiliconValleyRegional").document(teamNumber).collection("Matches").document(documentID).setData([
            "matchType":matchType,
            "matchNumber":matchNumber,
            "autoLowCube":autoLowCube,
            "autoMidCube":autoMidCube,
            "autoHighCube":autoHighCube,
            "autoLowCone":autoLowCone,
            "autoMidCone":autoMidCone,
            "autoHighCone":autoHighCone,
            "autoChargeStation":autoChargeStation,
            "teleopLowCube":teleopLowCube,
            "teleopMidCube":teleopMidCube,
            "teleopHighCube":teleopHighCube,
            "teleopLowCone":teleopLowCone,
            "teleopMidCone":teleopMidCone,
            "teleopHighCone":teleopHighCone,
            "teleopChargeStation":teleopChargeStation
        ], merge: true) { error in
            if error == nil {
                
            } else {
                print("Something went wrong")
            }
        }
    }
    

    func getTeam(teamNumber: Int) {
                
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
    
        let docRef = db.collection("SiliconValleyRegional").document(String(teamNumber))
        docRef.getDocument(as: SVRTeamUno.self) { result in
            // The Result type encapsulates deserialization errors or
            // successful deserialization, and can be handled as follows:
            //
            //      Result
            //        /\
            //   Error  City
            print(result)
            switch result {
            case .success(let team):
                print("Yay")
                self.CalledTeam = team
                // A `City` value was successfully initialized from the DocumentSnapshot.
                print("City: \(team)")
            case .failure(let error):
                print("Nay")
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding city: \(error)")
            }
        }
    }
    
    private func getMatch(ID: String, i: String) {
        
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
        db.collection("SiliconValleyRegional").document(i).collection("Matches").document(ID).getDocument(as: Match.self) { result in
         
            print(result)
            switch result {
            case .success(let match):
                print("Yay")
                self.Matches.append(match)
                // A `City` value was successfully initialized from the DocumentSnapshot.
                print("City: \(match)")
                print(self.Matches)
            case .failure(let error):
                print("Nay")
                // A `City` value could not be initialized from the DocumentSnapshot.
                print("Error decoding city: \(error)")
            }
        }
    }
    
    func fetchMatchData(teamNumber: Int) {
        
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
        let i = String(teamNumber)
        
        let docRef = db.collection("MontereyBayRegional").document(i).collection("Matches")
        
        print("hello")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                self.Matches.removeAll()
                for document in querySnapshot!.documents {
                    self.getMatch(ID: document.documentID, i: i)
                   
                    print("\(document.documentID) => \(document.data())")
                }
                print(self.Matches)
            }
        }
    }
}
