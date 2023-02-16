//
//  MBRTeamViewModel.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
final class ViewModel: ObservableObject {
    
    //Uncanny amount of published variables because I suck at figuring out completion handlers
    @Published var MBRTeams: [basicTeam] = []
    @Published var CalledTeam: completeTeam?
    @Published var Matches: [Match] = []
    @Published var pitData: [pitInfo] = []
    @Published var isLoading = false
    
    //team stuff
    @Published var teamScore = 0.00
    @Published var teamConeAvg = 0.00
    @Published var teamCubeAvg = 0.00
    @Published var teamCSAvg = 0.00
    @Published var teamLow = 0
    @Published var teamHigh = 0
    
    //1st blue team stuff
    @Published var blueAlliance1Avg = 0.00
    @Published var blueAlliance1ConeAvg = 0.00
    @Published var blueAlliance1CubeAvg = 0.00
    @Published var blueAlliance1CSAvg = 0.00
    @Published var blueAlliance1Low = 0
    @Published var blueAlliance1High = 0
    
    //2nd blue team stuff
    @Published var blueAlliance2Avg = 0.00
    @Published var blueAlliance2ConeAvg = 0.00
    @Published var blueAlliance2CubeAvg = 0.00
    @Published var blueAlliance2CSAvg = 0.00
    @Published var blueAlliance2Low = 0
    @Published var blueAlliance2High = 0
    
    
    //3rd blue team stuff
    @Published var blueAlliance3Avg = 0.00
    @Published var blueAlliance3ConeAvg = 0.00
    @Published var blueAlliance3CubeAvg = 0.00
    @Published var blueAlliance3CSAvg = 0.00
    @Published var blueAlliance3Low = 0
    @Published var blueAlliance3High = 0
    
    
    //1st red team stuff
    @Published var redAlliance1Avg = 0.00
    @Published var redAlliance1ConeAvg = 0.00
    @Published var redAlliance1CubeAvg = 0.00
    @Published var redAlliance1CSAvg = 0.00
    @Published var redAlliance1Low = 0
    @Published var redAlliance1High = 0
    
    //2nd red team stuff
    @Published var redAlliance2Avg = 0.00
    @Published var redAlliance2ConeAvg = 0.00
    @Published var redAlliance2CubeAvg = 0.00
    @Published var redAlliance2CSAvg = 0.00
    @Published var redAlliance2Low = 0
    @Published var redAlliance2High = 0
    
    //3rd red team stuff
    @Published var redAlliance3Avg = 0.00
    @Published var redAlliance3ConeAvg = 0.00
    @Published var redAlliance3CubeAvg = 0.00
    @Published var redAlliance3CSAvg = 0.00
    @Published var redAlliance3Low = 0
    @Published var redAlliance3High = 0
    
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
                           let teams = try? decoder.decode ([basicTeam].self, from: data) {
                            
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
    
    func downloadPitJSON(teamnumber: String, drivetrainType: String, motorType: String, programmingLanguage: String, placeLow: Bool, placeMid: Bool, placeHigh: Bool, intakeCone: Bool, intakeCube: Bool, intakeFallenCone: Bool, cycleTime: String, intakeFromShelf: Bool, intakeFromGround: Bool) throws -> Void {
        
        let data = pitInfo(teamnumber: teamnumber, drivetrainType: drivetrainType, motorType: motorType, programmingLanguage: programmingLanguage, canPlaceLow: placeLow, canPlaceMid: placeMid, canPlaceHigh: placeHigh, canPickCone: intakeCone, canPickCube: intakeCube, canPickFallenCones: intakeFallenCone, cycleTimes: cycleTime, canPickFromGround: intakeFromGround, canPickFromShelf: intakeFromShelf)
        
        //encode the data
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let jsonData = try encoder.encode(data)
        
        //Get the documents directory
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Failed to get documents directory.")
        }
        
        //Get the pitData directory
        let pitDataDirectory = documentsDirectory.appendingPathComponent("pitData")
        
        //Check if pitData directory exists
        if !FileManager.default.fileExists(atPath: pitDataDirectory.path) {
            do {
                try FileManager.default.createDirectory(at: pitDataDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }
        
        //Write to directory
        let fileURL = pitDataDirectory.appendingPathComponent("\(teamnumber)Pit.json")
        try jsonData.write(to: fileURL)
    }
    
    func getAllData(dir: String) throws -> [URL] {
        
        var directoryURL: URL
        
        if dir == "pit" {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("Failed to get documents directory.")
            }

            directoryURL = documentsDirectory.appendingPathComponent("pitData")
            
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                do {
                    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Error creating directory: \(error.localizedDescription)")
                }
            }
        } else {
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("Failed to get documents directory.")
            }

            directoryURL = documentsDirectory.appendingPathComponent("fieldData")
            
            if !FileManager.default.fileExists(atPath: directoryURL.path) {
                do {
                    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("Error creating directory: \(error.localizedDescription)")
                }
            }
        }
        
        var fileURLs: [URL] = []
        
        do {
            fileURLs = try FileManager.default.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [])
        } catch {
            fatalError("oopsie")
        }
        
        return fileURLs
    }
    
    func decodePitData(file: URL) -> pitInfo {
        let decoder = JSONDecoder()
        var data: Data
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("oopsie")
        }
        
        do {
            let decodedData = try decoder.decode(pitInfo.self, from: data)
            return decodedData
        } catch {
            fatalError("oopsie pt. 2")
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
        docRef.getDocument(as: completeTeam.self) { result in
            print(result)
            switch result {
            case .success(let team):
                print("Yay")
                self.CalledTeam = team
                print("City: \(team)")
            case .failure(let error):
                print("Nay")
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
    
    func getAverageScore(teamNumber: String, alliance: String, team: Int) {
        
        //Deal with an empty TextField
        if (teamNumber.isEmpty || teamNumber == "") {
            if alliance == "Blue" {
                if team == 1 {
                    self.blueAlliance1Avg = 0.00
                    self.blueAlliance1ConeAvg = 0.00
                    self.blueAlliance1CubeAvg = 0.00
                    self.blueAlliance1CSAvg = 0.00
                    self.blueAlliance1Low = 0
                    self.blueAlliance1High = 0
                } else if team == 2 {
                    self.blueAlliance2Avg = 0.00
                    self.blueAlliance2ConeAvg = 0.00
                    self.blueAlliance2CubeAvg = 0.00
                    self.blueAlliance2CSAvg = 0.00
                    self.blueAlliance2Low = 0
                    self.blueAlliance2High = 0
                } else {
                    self.blueAlliance3Avg = 0.00
                    self.blueAlliance3ConeAvg = 0.00
                    self.blueAlliance3CubeAvg = 0.00
                    self.blueAlliance3CSAvg = 0.00
                    self.blueAlliance3Low = 0
                    self.blueAlliance3High = 0
                }
            } else if alliance == "Red" {
                if team == 1 {
                    self.redAlliance1Avg = 0.00
                    self.redAlliance1ConeAvg = 0.00
                    self.redAlliance1CubeAvg = 0.00
                    self.redAlliance1CSAvg = 0.00
                    self.redAlliance1Low = 0
                    self.redAlliance1High = 0
                } else if team == 2 {
                    self.redAlliance2Avg = 0.00
                    self.redAlliance2ConeAvg = 0.00
                    self.redAlliance2CubeAvg = 0.00
                    self.redAlliance2CSAvg = 0.00
                    self.redAlliance2Low = 0
                    self.redAlliance2High = 0
                } else {
                    self.redAlliance3Avg = 0.00
                    self.redAlliance3ConeAvg = 0.00
                    self.redAlliance3CubeAvg = 0.00
                    self.redAlliance3CSAvg = 0.00
                    self.redAlliance3Low = 0
                    self.redAlliance3High = 0
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
                
                var conesScore: [Int] = []
                var cubesScore: [Int] = []
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
                    
                    //Average cone
                    let autoConeScore = autoLowCone * 3 + autoMidCone * 4 + autoHighCone * 6
                    let teleopConeScore = teleopLowCone * 2 + teleopMidCone * 3 + teleopHighCone * 5
                    
                    conesScore.append(autoConeScore + teleopConeScore)
                    
                    //Average Cube
                    let autoCubeScore = autoLowCube * 3 + autoMidCube * 4 + autoHighCube * 6
                    let teleopCubeScore = teleopLowCube * 2 + teleopMidCube * 3 + teleopHighCube * 5
                    
                    cubesScore.append(autoCubeScore + teleopCubeScore)
                }
                
                //Get Score average
                var sum = 0
                for i in scores {
                    sum += i
                }
                let average = Double(sum) / Double(scores.count)
                
                //Get cone average
                var a = 0
                for i in conesScore {
                    a += i
                }
                let coneAverage = Double(a) / Double(conesScore.count)
                
                //Get cube average
                var u = 0
                for i in cubesScore {
                    u += i
                }
                let cubeAverage = Double(u) / Double(cubesScore.count)
                
                if alliance == "Blue" {
                    if team == 1 {
                        self.blueAlliance1Avg = average
                        self.blueAlliance1ConeAvg = coneAverage
                        self.blueAlliance1CubeAvg = cubeAverage
                        self.blueAlliance1CSAvg = average - (cubeAverage + coneAverage)
                        self.blueAlliance1Low = scores.min() ?? 0
                        self.blueAlliance1High = scores.max() ?? 0
                    } else if team == 2 {
                        self.blueAlliance2Avg = average
                        self.blueAlliance2ConeAvg = coneAverage
                        self.blueAlliance2CubeAvg = cubeAverage
                        self.blueAlliance2CSAvg = average - (cubeAverage + coneAverage)
                        self.blueAlliance2Low = scores.min() ?? 0
                        self.blueAlliance2High = scores.max() ?? 0
                    } else {
                        self.blueAlliance3Avg = average
                        self.blueAlliance3ConeAvg = coneAverage
                        self.blueAlliance3CubeAvg = cubeAverage
                        self.blueAlliance3CSAvg = average - (cubeAverage + coneAverage)
                        self.blueAlliance3Low = scores.min() ?? 0
                        self.blueAlliance3High = scores.max() ?? 0
                    }
                } else if alliance == "Red" {
                    if team == 1 {
                        self.redAlliance1Avg = average
                        self.redAlliance1ConeAvg = coneAverage
                        self.redAlliance1CubeAvg = cubeAverage
                        self.redAlliance1CSAvg = average - (cubeAverage + coneAverage)
                        self.redAlliance1Low = scores.min() ?? 0
                        self.redAlliance1High = scores.max() ?? 0
                        
                    } else if team == 2 {
                        self.redAlliance2Avg = average
                        self.redAlliance2ConeAvg = coneAverage
                        self.redAlliance2CubeAvg = cubeAverage
                        self.redAlliance2CSAvg = average - (cubeAverage + coneAverage)
                        self.redAlliance2Low = scores.min() ?? 0
                        self.redAlliance2High = scores.max() ?? 0
                    } else {
                        self.redAlliance3Avg = average
                        self.redAlliance3ConeAvg = coneAverage
                        self.redAlliance3CubeAvg = cubeAverage
                        self.redAlliance3CSAvg = average - (cubeAverage + coneAverage)
                        self.redAlliance3Low = scores.min() ?? 0
                        self.redAlliance3High = scores.max() ?? 0
                    }
                } else {
                    self.teamScore = average
                    self.teamConeAvg = coneAverage
                    self.teamCubeAvg = cubeAverage
                    self.teamCSAvg = average - (cubeAverage + coneAverage)
                    self.teamLow = scores.min() ?? 0
                    self.teamHigh = scores.max() ?? 0
                    
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
