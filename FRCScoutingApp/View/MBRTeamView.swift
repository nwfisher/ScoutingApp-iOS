//
//  MBRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI
import Charts


struct MBRTeamView: View {
    
    let team: basicTeam
    @StateObject var vm = ViewModel()
    
    let err = completeTeam(team_number: 0000, nickname: "No Info", drivetrainType: "No Info", motorType: "No Info", programmingLanguage: "No Info", canPlaceLow: false, canPlaceMid: false, canPlaceHigh: false, canPickCone: false, canPickCube: false, canPickFallenCones: false, cycleTimes: "No Info", intakeFromGround: false, intakeFromSingle: false, intakeFromDouble: false)
    
    var body: some View {
        let trueTeam = vm.CalledTeam
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    let i: String = String(team.team_number)
                    Text(i)
                        .font(.title)
                        .bold()
                    
                    
                    Text("**Team Name**: \(team.nickname)")
                    Divider()
                }
                Group {
                    Text("Basic Information")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                Group {
                    robotInfo(team: trueTeam ?? err)
                    Divider()
                    scoringHeights(team: trueTeam ?? err)
                    gamePieces(team: trueTeam ?? err)
                    intakeLocations(team: trueTeam ?? err)
                    cycleTime(team: trueTeam ?? err)
                    Divider()
                }
                Spacer()
                Text("Advanced Statistics")
                    .font(.title2)
                    .bold()
                Spacer()
                Group {
                    Text("Average Score")
                        .bold()
                        .font(.title3)
                    Text(String(round(vm.teamScore * 100) / 100.0))
                    Text("Average Cone")
                        .bold()
                        .font(.title3)
                    Text(String(round(vm.teamConeAvg * 100) / 100.0))
                    Text("Average Cube")
                        .bold()
                        .font(.title3)
                    Text(String(round(vm.teamCubeAvg * 100) / 100.0))
                }
                Group {
                    Text("Average Charge Station")
                        .bold()
                        .font(.title3)
                    Text(String(round(vm.teamCSAvg * 100) / 100.0))
                    Text("Lowest match score")
                        .bold()
                        .font(.title3)
                    Text(String(vm.teamLow))
                    Text("Highest match score")
                        .bold()
                        .font(.title3)
                    Text(String(vm.teamHigh))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity).ignoresSafeArea()
            .padding()
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous)).ignoresSafeArea()
            .padding(.horizontal, 4)
            
            
            .onAppear {
                vm.getTeam(teamNumber: team.team_number)
                vm.getAverageScore(teamNumber: String(team.team_number), alliance: "None", team: 0)
            }
        }
    }
}

struct MBRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MBRTeamView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", intakeFromDouble: true, intakeFromSingle: true, intakeFromGround: true))
    }
}
