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
    let name: String
    let alliance: String
    let points: Int
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
    @ObservedObject var vm = MBRTeamViewModel()
    
    @State private var blueAlliance1 = ""
    @State private var redAlliance1 = ""
    @State private var blueAlliance2 = ""
    @State private var redAlliance2 = ""
    @State private var blueAlliance3 = ""
    @State private var redAlliance3 = ""
    var body: some View {
      
        VStack {
        /*    ZStack {
                Color(hex: "#2c9c00").ignoresSafeArea()
                
                HStack{
                    //Profile Picture Image
                    Image( "6623BA4C-73C7-444C-AA45-2B402A36904A_1_105_c")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75.0)
                        .clipShape(Circle())
                        .padding(.leading)
                    
                    //Welcome User
                    Text("Welcome, Nick!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(0.0)
                        .foregroundColor(Color(hex: "#FDDA24"))
                        
                    
                    
                }
                
            }
            //Set frame height of Colored Bar
            //.frame(height: 100)*/
            
            //Create list of events
            NavigationStack {
                List {
                    Section(header: Text("Team Lists").font(.headline).bold()) {
                        NavigationLink(destination: MBRView()) {
                            Text("Monterey Bay Regional")
                        }
                        NavigationLink(destination: SVRView()) {
                            Text("Silicon Valley Regional")
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
                      
            
                                    vm.getAverageScore(teamNumber: redAlliance1, alliance: "Red", team: 3)
                               
                                
                                
                               // vm.predictWinner()
                                //vm.getRedScore()
                                //vm.getBlueScore()
                
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
                    /*Section(header: Text("Advanced Statistics")) {
                        HStack {
                            Text("     ")
                            Spacer()
                            Divider()
                            blueAlliance1.isEmpty ?  Text("0000") :  Text(blueAlliance1)
                            Spacer()
                            Divider()
                            blueAlliance2.isEmpty ?  Text("0000") :  Text(blueAlliance2)
                            Spacer()
                            Group {
                                Divider()
                                blueAlliance3.isEmpty ?  Text("0000") :  Text(blueAlliance3)
                                Spacer()
                            }
                        }*/
                    
                    var predictedScoring: [Team] = [
                        Team(name: blueAlliance1, alliance: "Blue", points: Int(round(vm.blueAlliance1Avg))),
                        Team(name: blueAlliance2, alliance: "Blue", points: Int(round(vm.blueAlliance2Avg))),
                        Team(name: blueAlliance3, alliance: "Blue", points: Int(round(vm.blueAlliance3Avg))),
                        Team(name: redAlliance1, alliance: "Red", points: Int(round(vm.redAlliance1Avg))),
                        Team(name: redAlliance2, alliance: "Red", points: Int(round(vm.redAlliance2Avg))),
                        Team(name: redAlliance3, alliance: "Red", points: Int(round(vm.redAlliance3Avg)))
                    ]
                    
                    Chart {
                        ForEach(predictedScoring) { scoring in
                            BarMark(
                                x: .value("Team", scoring.name),
                                y: .value("Score", scoring.points)
                            ).foregroundStyle(by: .value("Alliance Color", scoring.alliance))
                        }
                    }.chartForegroundStyleScale(["Blue":.blue, "Red":.red])
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

