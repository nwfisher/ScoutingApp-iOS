//
//  SVRTeamView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI

struct SVRTeamView: View {
    let team: SVRTeam
    var body: some View {
        VStack(alignment: .leading) {
            Text("**Team Number**: \(team.team_number)")
            Text("**Name**: \(team.nickname)]")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct SVRTeamView_Previews: PreviewProvider {
    static var previews: some View {
        SVRTeamView(team: .init(team_number: 4255, nickname: "Robodores"))
    }
}
