//
//  MBRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI
import Charts


struct MBRTeamView: View {
    
    let team: MBRTeam
    @StateObject var vm = MBRTeamViewModel()
    
    let err = MBRTeamUno(team_number: 0000, nickname: "Error", drivetrainType: "Error", motorType: "Error", programmingLanguage: "Error", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "Error", canPickFromGround: true, canPickFromShelf: true)
    
    var body: some View {
        var trueTeam = vm.CalledTeam
        let _ = print(vm.CalledTeam)
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
                var matchesScoreRange: [scoringHeights] = []
                
                Group {
                    
                }
    
                
                Text(String(vm.teamScore))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity).ignoresSafeArea()
            .padding()
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous)).ignoresSafeArea()
            .padding(.horizontal, 4)
            
            
            .onAppear {
                vm.getTeam(teamNumber: team.team_number)
            }
        }
    }
}

struct MBRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MBRTeamView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
