//
//  HomeView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/5/23.
//

import SwiftUI
import Charts

struct Team: Identifiable {
    let id = UUID()
    let points: Double
    let type: String
    let team: String
}

struct scoringRange: Identifiable {
    let id = UUID()
    let name: String
    let alliance: String
    let highestScore: Int
    let lowestScore: Int
}
struct HomeView: View {
    
    @State var temp = false
    @State var searchText = ""
    @ObservedObject var vm = ViewModel()
    
    @State private var blueAlliance1 = ""
    @State private var redAlliance1 = ""
    @State private var blueAlliance2 = ""
    @State private var redAlliance2 = ""
    @State private var blueAlliance3 = ""
    @State private var redAlliance3 = ""
    var body: some View {
      
        VStack {
            //Create list of events
            NavigationStack {
                List {
                    Section(header: Text("Team List").font(.headline).bold()) {
                        NavigationLink(destination: MBRView()) {
                            Text("Monterey Bay Regional")
                        }
                    }
                    Section(header: Text("Stats and Predictions").font(.headline).bold()) {
                        HStack {
                            TextField("Blue Alliance Team", text: $blueAlliance1)
                            Divider()
                            TextField("Red Alliance Team", text: $redAlliance1)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        HStack {
                            TextField("Blue Alliance Team", text: $blueAlliance2)
                            Divider()
                            TextField("Red Alliance Team", text: $redAlliance2)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        HStack {
                            TextField("Blue Alliance Team", text: $blueAlliance3)
                            Divider()
                            TextField("Red Alliance Team", text: $redAlliance3)
                        }.frame(maxWidth: .infinity, alignment: .center)
                        
                        HStack {
                            Button(action: {
                                    vm.getAverageScore(teamNumber: blueAlliance1, alliance: "Blue", team: 1)
                                    vm.getAverageScore(teamNumber: redAlliance1, alliance: "Red", team: 1)
                                    vm.getAverageScore(teamNumber: blueAlliance2, alliance: "Blue", team: 2)
                                    vm.getAverageScore(teamNumber: redAlliance2, alliance: "Red", team: 2)
                                    vm.getAverageScore(teamNumber: blueAlliance3, alliance: "Blue", team: 3)
                                    vm.getAverageScore(teamNumber: redAlliance3, alliance: "Red", team: 3)
        
                                print("View stuff")
                                print(vm.winner)
                                print(vm.blueScore)
                                print(vm.redScore)
                            }, label: {
                                Text("Predict")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40.0)
                                    .background(Color(hex: "2c9c00"))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .bold()
                            })
                        }
                        
                        HStack(alignment: .center) {
                            Text(String(vm.blueScore))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .listRowBackground(Color.blue)
                            Divider()
                            Text(String(vm.redScore)).frame(maxWidth: .infinity, alignment: .trailing)
                        }.frame(maxWidth: .infinity, alignment: .center)
                            .listRowBackground(Color.gray.opacity(0.1))
                        if vm.winner == 1 {
                            Text("Blue Alliance Wins!")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .listRowBackground(Color.blue)
                        } else if vm.winner == 2 {
                            Text("Red Alliance Wins")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .listRowBackground(Color.red)
                        } else if vm.winner == 3 {
                            Text("Tie!")
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            Text("Add teams")
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        
                    }
                    
                    var predictedScoring: [Team] = [
                        Team(points: vm.blueAlliance1CubeAvg, type: "Cube", team: blueAlliance1),
                        Team(points: vm.blueAlliance2CubeAvg, type: "Cube", team: blueAlliance2),
                        Team(points: vm.blueAlliance3CubeAvg, type: "Cube", team: blueAlliance3),
                        Team(points: vm.blueAlliance1ConeAvg, type: "Cone", team: blueAlliance1),
                        Team(points: vm.blueAlliance2ConeAvg, type: "Cone", team: blueAlliance2),
                        Team(points: vm.blueAlliance3ConeAvg, type: "Cone", team: blueAlliance3),
                        Team(points: vm.blueAlliance1CSAvg, type: "Charge Station", team: blueAlliance1),
                        Team(points: vm.blueAlliance2CSAvg, type: "Charge Station", team: blueAlliance2),
                        Team(points: vm.blueAlliance3CSAvg, type: "Charge Station", team: blueAlliance3),
                        Team(points: vm.redAlliance1CubeAvg, type: "Cube", team: redAlliance1),
                        Team(points: vm.redAlliance2CubeAvg, type: "Cube", team: redAlliance2),
                        Team(points: vm.redAlliance3CubeAvg, type: "Cube", team: redAlliance3),
                        Team(points: vm.redAlliance1ConeAvg, type: "Cone", team: redAlliance1),
                        Team(points: vm.redAlliance2ConeAvg, type: "Cone", team: redAlliance2),
                        Team(points: vm.redAlliance3ConeAvg, type: "Cone", team: redAlliance3),
                        Team(points: vm.redAlliance1CSAvg, type: "Charge Station", team: redAlliance1),
                        Team(points: vm.redAlliance2CSAvg, type: "Charge Station", team: redAlliance2),
                        Team(points: vm.redAlliance3CSAvg, type: "Charge Station", team: redAlliance3),
                    ]
                    
                    Chart {
                        ForEach(predictedScoring) { scoring in
                            BarMark(
                                x: .value("Team", scoring.team),
                                y: .value("Score", scoring.points)
                            ).foregroundStyle(by: .value("Game Piece", scoring.type))
                        }
                    }
                    .chartForegroundStyleScale([
                        "Cube": .purple, "Cone": .yellow, "Charge Station": Color(hex: "2c9c00")
                    ])
                    .frame(height: 250)
                    var scoring: [scoringRange] = [
                        scoringRange(name: blueAlliance1, alliance: "Blue", highestScore: vm.blueAlliance1High, lowestScore: vm.blueAlliance1Low),
                        scoringRange(name: blueAlliance2, alliance: "Blue", highestScore: vm.blueAlliance2High, lowestScore: vm.blueAlliance2Low),
                        scoringRange(name: blueAlliance3, alliance: "Blue", highestScore: vm.blueAlliance3High, lowestScore: vm.blueAlliance3Low),
                        scoringRange(name: redAlliance1, alliance: "Red", highestScore: vm.redAlliance1High, lowestScore: vm.redAlliance1Low),
                        scoringRange(name: redAlliance2, alliance: "Red", highestScore: vm.redAlliance2High, lowestScore: vm.redAlliance2Low),
                        scoringRange(name: redAlliance3, alliance: "Red", highestScore: vm.redAlliance3High, lowestScore: vm.redAlliance3Low)
                    ]
                    Spacer()
                    Chart {
                        ForEach(scoring) { team in
                            RuleMark(
                                xStart: .value("Lowest Score", team.lowestScore),
                                xEnd: .value("Highest Score", team.highestScore),
                                y: .value("Team", team.name)
                            ).foregroundStyle(by: .value("Alliance", team.alliance))
                        }
                    }.chartForegroundStyleScale([
                        "Blue": .blue, "Red": .red
                    ])
                }
                .navigationTitle("Events")
                
             
                
            }
            
            //Link to Blue Alliance
            Link("The Blue Alliance", destination: URL(string: "https://www.thebluealliance.com")!)
                .fontWeight(.bold)
                .font(.title3)
                .padding()
                Spacer()
            
        }
    }
}
    
    
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Allow for use of HEX Colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

