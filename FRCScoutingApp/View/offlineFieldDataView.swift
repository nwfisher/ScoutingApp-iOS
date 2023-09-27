//
//  offlineFieldDataView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/16/23.
//

import SwiftUI

struct offlineFieldDataView: View {
    
    let reachability = try? Reachability()
    @StateObject private var vm = ViewModel()
    @State private var showingAlert = false
    @State private var noInternet = false
    @State private var files: [URL] = []
    var body: some View {
        NavigationStack {
            VStack {
                if !files.isEmpty {
                    List {
                        ForEach(files, id: \.self) { file in
                                
                                let match = vm.decodeFieldData(file: file)
                                
                            let i = String(match.matchID)
                                
                                Text("**\(i)**\n\(file.lastPathComponent)")
                            
                        }
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                    
                    Button(action: {
                        if reachability?.connection == .unavailable {
                            noInternet.toggle()
                        } else {
                            for file in files {
                                
                                let team = vm.decodeFieldData(file: file)
                                
                                vm.addMatchData(teamNumber: team.teamNumber, matchNumber: team.matchNumber, matchType: team.matchType, autoLowCube: team.autoLowCube, autoMidCube: team.autoMidCube, autoHighCube: team.autoHighCube, autoLowCone: team.autoLowCone, autoMidCone: team.autoMidCone, autoHighCone: team.autoHighCone, teleopLowCube: team.teleopLowCube, teleopMidCube: team.teleopMidCube, teleopHighCube: team.teleopHighCube, teleopLowCone: team.teleopLowCone, teleopMidCone: team.teleopMidCone, teleopHighCone: team.teleopHighCone, autoChargeStationPts: team.autoChargeStationPts, endgame: team.endgame, notes: team.notes)
                            }
                            
                            showingAlert.toggle()
                        }
                    }, label: {
                        Text("Push data")
                            .frame(maxWidth: .infinity)
                            .frame(height: 60.0)
                            .background(Color.init(hex: "2c9c00"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .bold()
                    })
                    .alert("Data pushed!", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    .alert("No Connection! Cannot Push to Firebase", isPresented: $noInternet) {
                        Button("OK", role: .cancel) {
                            noInternet.toggle()
                        }
                    }

                } else {
                    Text("No data!")
                }
            }
            .onAppear {
                do {
                    self.files = try vm.getAllData(dir: "field")
                } catch {
                    print("Could not read data")
                }
            }
        }

    }
}

struct offlineFieldDataView_Previews: PreviewProvider {
    static var previews: some View {
        offlineFieldDataView()
    }
}
