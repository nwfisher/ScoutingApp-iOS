//
//  MBRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI

struct MBRTeamView: View {
    
    let team: MBRTeam
   
    
    var body: some View {
        
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
                    
                Group {
                    robotInformationView(team: team)
                }
                Group {
                    scoringLocationsView(team: team)
                }
                Group {
                    scoringHeightsView(team: team)
                }
                Group {
                    intakingView(team: team)
                }
                Group {
                    intakingLocationsView(team: team)
                }
                 Group {
                     cycleTimeView(team: team)
                     Divider()
                 }
                
                
                    NavigationLink(destination: HomepageView()) {
                        Text("Matches")
                    }
                    .font(.title3)
                    .foregroundColor(.blue)
                    .bold()
                    .underline()
               
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(maxHeight: .infinity).ignoresSafeArea()
            .padding()
            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .padding(.horizontal, 4)
        }
    }
}

struct MBRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        MBRTeamView(team: .init(team_number: 4255, nickname: "Robodores", drivetrainType: "Swerve", motorType: "Falcon 500", programmingLanguage: "Java", canPlaceLow: true, canPlaceMid: true, canPlaceHigh: false, canPickCone: true, canPickCube: true, canPickFallenCones: false, cycleTimes: "15", canPickFromGround: true, canPickFromShelf: true))
    }
}
