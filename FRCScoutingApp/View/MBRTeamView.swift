//
//  MBRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI


struct MBRTeamView: View {
    
    let team: MBRTeam
   @StateObject var vm = MBRTeamViewModel()
    
    var body: some View {
        var trueTeam = vm.CalledTeam
        let _ = print(vm.CalledTeam)
        ScrollView {
            VStack(alignment: .leading) {
                let i: String = String(team.team_number)
                Text(i)
                    .font(.title)
                    .bold()
                
                Text("**Team Name**: \(team.nickname)")
                Divider()
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                if (trueTeam != nil) {
                    Group {
                        robotInformationView(team: trueTeam!)
                    }
                    Group {
                        scoringLocationsView(team: trueTeam!)
                    }
                    Group {
                        scoringHeightsView(team: trueTeam!)
                        intakingView(team: trueTeam!)
                    }
                    Group {
                        intakingLocationsView(team: trueTeam!)
                    }
                    Group {
                        cycleTimeView(team: trueTeam!)
                        Divider()
                    }
                    
                    
                    NavigationLink(destination: HomepageView()) {
                        Text("Matches")
                    }
                    .font(.title3)
                    .foregroundColor(.blue)
                    .bold()
                    .underline()
                    
                } else {
                    Text("No Data")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity).ignoresSafeArea()
            .padding()
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 4)
        }
        .onAppear {
            vm.getTeam(teamNumber: team.team_number)
        }
    }
}

struct MBRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MBRTeamView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
