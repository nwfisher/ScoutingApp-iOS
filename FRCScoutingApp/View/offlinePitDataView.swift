//
//  offlinePitDataView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/16/23.
//

import SwiftUI

struct offlinePitDataView: View {
    
    let reachability = try? Reachability()
    @State private var showingAlert = false
    @State private var noInternet = false
    @StateObject private var vm = ViewModel()
    @State private var files: [URL] = []
    var body: some View {
        NavigationStack {
            VStack {
                  if !files.isEmpty {
                    List {
                        ForEach(files, id: \.self) { file in
                                
                                let team = vm.decodePitData(file: file)
                                
                                let i = String(team.teamnumber)
                                
                                Text("**\(i)**\n\(file.lastPathComponent)")
                            
                        }
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                    
                    Button(action: {
                        if reachability?.connection == .unavailable {
                            noInternet.toggle();
                        } else {
                            for file in files {
                                
                                let team = vm.decodePitData(file: file)
                                
                                vm.addPitData(teamnumber: team.teamnumber, drivetrainType: team.drivetrainType, motorType: team.motorType, programmingLanguage: team.programmingLanguage, placeLow: team.canPlaceLow, placeMid: team.canPlaceMid, placeHigh: team.canPlaceHigh, intakeCone: team.canPickCone, intakeCube: team.canPickCube, intakeFallenCone: team.canPickFallenCones, cycleTime: team.cycleTimes, intakeFromDouble: team.canPickFromDouble, intakeFromSingle: team.canPickFromSingle, intakeFromGround: team.canPickFromGround)
                                
                                showingAlert.toggle()
                            }
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
                    self.files = try vm.getAllData(dir: "pit")
                } catch {
                    print("Could not read data")
                }
            }
        }

    }
}

struct offlinePitDataView_Previews: PreviewProvider {
    static var previews: some View {
        offlinePitDataView()
    }
}
