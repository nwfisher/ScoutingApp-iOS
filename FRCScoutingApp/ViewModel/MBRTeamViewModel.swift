//
//  MBRTeamViewModel.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
final class MBRTeamViewModel: ObservableObject {
    
    //Uncanny amount of published variables because I suck at figuring out completion handlers
    @Published var MBRTeams: [MBRTeam] = []
    @Published var CalledTeam: MBRTeamUno?
    @Published var Matches: [Match] = []
    @Published var teamScore = 0.00
    
    @Published var blueAlliance1Avg = 0.00
    @Published var blueAlliance2Avg = 0.00
    @Published var blueAlliance3Avg = 0.00
    @Published var redAlliance1Avg = 0.00
    @Published var redAlliance2Avg = 0.00
    @Published var redAlliance3Avg = 0.00
    
    @Published var winner = 3
    @Published var redScore = 0.00
    @Published var blueScore = 0.00
    
    func fetchTeams () {
        let url = URL(string: "https://www.thebluealliance.com/api/v3/event/2023camb/teams")!
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
                                let teams = try? decoder.decode ([MBRTeam].self, from: data) {
                                
                                    self?.MBRTeams = teams
                                } else {
                                    
                                }
                            }
                        }
                       
                    }.resume()
    }
    
    //Quick, one time function so I don't need to do work
    //This function will likley never have to be used again
    func resetTeams() {
       
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
        for team in self.MBRTeams {
            db.collection("MontereyBayRegional").document(String(team.team_number)).setData([
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
        
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
       // let i = String(teamnumber)
        
        db.collection("MontereyBayRegional").document(teamnumber).setData([
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
            "intakeFromGround":intakeFromGround
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
        
        db.collection("MontereyBayRegional").document(teamNumber).collection("Matches").document(documentID).setData([
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
    
        let docRef = db.collection("MontereyBayRegional").document(String(teamNumber))
        docRef.getDocument(as: MBRTeamUno.self) { result in
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
        
        db.collection("MontereyBayRegional").document(i).collection("Matches").document(ID).getDocument(as: Match.self) { result in
         
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
    
    func deleteData() {
        
    }
    
    func getAverageScore(teamNumber: String, alliance: String, team: Int) {
        
        if (teamNumber.isEmpty || teamNumber == "") {
            if alliance == "Blue" {
                if team == 1 {
                    self.blueAlliance1Avg = 0.00
                } else if team == 2 {
                    self.blueAlliance2Avg = 0.00
                } else {
                    self.blueAlliance3Avg = 0.00
                }
            } else if alliance == "Red" {
                if team == 1 {
                    self.redAlliance1Avg = 0.00
                } else if team == 2 {
                    self.redAlliance2Avg = 0.00
                } else {
                    self.redAlliance3Avg = 0.00
                }
            } else {
                self.teamScore = 0.00
            }
            return
        }
        
        if FirebaseApp.app() == nil {
                  FirebaseApp.configure()
              }
        let db = Firestore.firestore()
        
        let docRef = db.collection("MontereyBayRegional").document(teamNumber).collection("Matches")
        print("Team: \(teamNumber)")
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                var scores: [Int] = []
                for document in querySnapshot!.documents {
                    
                    //Autonomous
                    let autoLowCube = document.get("autoLowCube") as? Int ?? 0
                    let autoLowCone = document.get("autoLowCone") as? Int ?? 0
                    let autoMidCube = document.get("autoMidCube") as? Int ?? 0
                    let autoMidCone = document.get("autoMidCone") as? Int ?? 0
                    let autoHighCube = document.get("autoHighCube") as? Int ?? 0
                    let autoHighCone = document.get("autoHighCone") as? Int ?? 0
                    
                    //Teleop
                    let teleopLowCube = document.get("teleopLowCube") as? Int ?? 0
                    let teleopLowCone = document.get("teleopLowCone") as? Int ?? 0
                    let teleopMidCube = document.get("teleopMidCube") as? Int ?? 0
                    let teleopMidCone = document.get("teleopMidCone") as? Int ?? 0
                    let teleopHighCube = document.get("teleopHighCube") as? Int ?? 0
                    let teleopHighCone = document.get("teleopHighCone") as? Int ?? 0
                    
                    //Charge Station
                    let autoChargeStation = document.get("autoChargeStation") as? String ?? "None"
                    let teleopChargeStation = document.get("teleopChargeStation") as? String ?? "None"
                    
                    //Auto Score
                    var autoScore = (autoLowCube + autoLowCone) * 3 + (autoMidCone + autoMidCube) * 4 + (autoHighCone + autoHighCube) * 6
                    switch autoChargeStation {
                    case "None":
                        autoScore += 0
                    case "Mobility":
                        autoScore += 3
                    case "Docked":
                        autoScore += 8
                    case "Docked & Engaged":
                        autoScore += 12
                    default:
                        break
                    }
                    
                    //Teleoperated Score
                    var teleopScore = (teleopLowCone + teleopLowCube) * 2 + (teleopMidCone + teleopMidCube) * 3 + (teleopHighCone + teleopHighCube) * 5
                    switch teleopChargeStation {
                    case "None":
                        teleopScore += 0
                    case "Park":
                        teleopScore += 2
                    case "Docked":
                        teleopScore += 6
                    case "Docked & Engaged":
                        teleopScore += 10
                    default:
                        break
                    }
                    
                    scores.append(teleopScore + autoScore)
                    print(scores)
                }
                
                //Get Score average
                var sum = 0
                for i in scores {
                    sum += i
                }
                let average = Double(sum) / Double(scores.count)
                print(average)
                if alliance == "Blue" {
                    if team == 1 {
                        self.blueAlliance1Avg = average
                    } else if team == 2 {
                        self.blueAlliance2Avg = average
                    } else {
                        self.blueAlliance3Avg = average
                    }
                } else if alliance == "Red" {
                    if team == 1 {
                        self.redAlliance1Avg = average
                    } else if team == 2 {
                        self.redAlliance2Avg = average
                    } else {
                        self.redAlliance3Avg = average
                    }
                } else {
                    self.teamScore = average
                }
                
                self.predictWinner()
                self.getRedScore()
                self.getBlueScore()
                
            }
        }
    }
    
    func predictWinner() -> Void{
        let blueAllianceScore = self.blueAlliance1Avg + self.blueAlliance2Avg + self.blueAlliance3Avg
        let redAllianceScore = self.redAlliance1Avg + self.redAlliance2Avg + self.redAlliance3Avg
        
        if blueAllianceScore > redAllianceScore {
            self.winner = 1
        } else if redAllianceScore > blueAllianceScore {
            self.winner = 2
        } else {
            self.winner = 3
        }
    }
    
    func getRedScore() -> Void {
        self.redScore = self.redAlliance1Avg + self.redAlliance2Avg + self.redAlliance3Avg
    }
    
    func getBlueScore() -> Void {
        self.blueScore = self.blueAlliance1Avg + self.blueAlliance2Avg + self.blueAlliance3Avg
    }
}
