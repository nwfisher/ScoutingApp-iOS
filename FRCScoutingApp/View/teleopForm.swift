//
//  teleopForm.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/23/23.
//

import SwiftUI

struct teleopForm: View {
    
    let reachability = try? Reachability()
    @Environment(\.dismiss) private var dismiss
    @State private var sheetIsPresented = false
    @State private var reviewSheet = false
    @State private var noInternet = false
    @State private var pushAlert = false
    @State private var noFileSystem = false
    @State var goingHome = false
    
    //Viewmodels
    let vm = ViewModel()
    
    //Match Info
    let matchType: String
    let matchNumber: String
    let teamNumber: String
    
    //Auto scores
    let autoLowCube: Int
    let autoMidCube: Int
    let autoHighCube: Int
    let autoLowCone: Int
    let autoMidCone: Int
    let autoHighCone: Int
    
    //TeleOp scores
    @State var teleopLowCube = 0 //1
    @State var teleopMidCube = 0 //2
    @State var teleopHighCube = 0 //3
    @State var teleopLowCone = 0 //4
    @State var teleopMidCone = 0 //5
    @State var teleopHighCone = 0 //6
    
    //Charge station
    let autoChargeStation: Int
    @State var chargeStation = "NONE"
    
    //Allow for undo
    @State var mostRecentVariableChange = ""
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L1 - \(teleopLowCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopLowCube += 1
                            mostRecentVariableChange = "1"
                        }
                        Button(action: {}, label: {
                            Text("Cone L1 - \(teleopLowCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopLowCone += 1
                            mostRecentVariableChange = "4"
                        }
                    }
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L2 - \(teleopMidCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopMidCube += 1
                            mostRecentVariableChange = "2"
                        }
                        Button(action: {}, label: {
                            Text("Cone L2 - \(teleopMidCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopMidCone += 1
                            mostRecentVariableChange = "5"
                        }
                    }
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L3 - \(teleopHighCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopHighCube += 1
                            mostRecentVariableChange = "3"
                        }
                        Button(action: {}, label: {
                            Text("Cone L3 - \(teleopHighCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            teleopHighCone += 1
                            mostRecentVariableChange = "6"
                        }
                    }
                    Button(action: {
                        switch mostRecentVariableChange {
                        case "1":
                            teleopLowCube -= 1
                            mostRecentVariableChange = ""
                        case "2":
                            teleopMidCube -= 1
                            mostRecentVariableChange = ""
                        case "3":
                            teleopHighCube -= 1
                            mostRecentVariableChange = ""
                        case "4":
                            teleopLowCone -= 1
                            mostRecentVariableChange = ""
                        case "5":
                            teleopMidCone -= 1
                            mostRecentVariableChange = ""
                        case "6":
                            teleopHighCone -= 1
                            mostRecentVariableChange = ""
                        default: break
                        }
                    }, label: {
                        Text("Undo")
                            .frame(maxWidth: .infinity)
                            .frame(height: 50.0)
                            .background(Color(hex: "144600"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .bold()
                    })
                    
                    Button(action: {
                        sheetIsPresented.toggle()
                    }, label: {
                        Text("New Charge Station")
                            .frame(maxWidth: .infinity)
                            .frame(height: 60.0)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .bold()
                    })
                    
                    .sheet(isPresented: $sheetIsPresented) {
                        Text("Select Attempt")
                            .font(.title2)
                        
                        Divider()
                        
                        Button(action: {
                            chargeStation = "None"
                        }, label: {
                            Text("None")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        })
                        Button(action: {
                            chargeStation = "Park"
                        }, label: {
                            Text("Park")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        })
                        Button(action: {
                            chargeStation = "Docked"
                        }, label: {
                            Text("Docked")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        })
                        Button(action: {
                            chargeStation = "Docked & Engaged"
                        }, label: {
                            Text("Docked & Engaged")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        })
                        
                        Text("Selected Status: \(chargeStation)")
                            .presentationDetents([.fraction(0.6)])
                    }
                    
                    HStack {
                        Button(action: {}, label: {
                            Text("Back")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                            
                        }).onTapGesture {
                            dismiss()
                        }
                        Button(action: {}, label: {
                            Text("Submit")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color(hex: "2c9c00"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                            
                        }).onTapGesture {
                            reviewSheet.toggle()
                        }
                        
                        .sheet(isPresented: $reviewSheet) {
                            NavigationStack {
                                VStack(alignment: .leading) {
                                    Form {
                                        Section(header: Text("Match Info")) {
                                            Text("Match Type: \(matchType)")
                                            Text("Match Number: \(matchNumber)")
                                            Text("Team Number: \(teamNumber)")
                                        }
                                        
                                        Section(header: Text("Autonomous Period")) {
                                            Text("L1 Cube: \(autoLowCube)")
                                            Text("L2 Cube: \(autoMidCube)")
                                            Text("L3 Cube: \(autoHighCube)")
                                            Text("L1 Cone: \(autoLowCone)")
                                            Text("L2 Cone: \(autoMidCone)")
                                            Text("L3 Cone: \(autoHighCone)")
                                            Text("Points off Charge Station: \(autoChargeStation)")
                                        }
                                        
                                        Section(header: Text("teleoperated period")) {
                                            Text("L1 Cube: \(teleopLowCube)")
                                            Text("L2 Cube: \(teleopMidCube)")
                                            Text("L3 Cube: \(teleopHighCube)")
                                            Text("L1 Cone: \(teleopLowCone)")
                                            Text("L2 Cone: \(teleopMidCone)")
                                            Text("L3 Cone: \(teleopHighCone)")
                                            Text("Charge Station: \(chargeStation)")
                                        }
                                        
                                        Section(header: Text("confirm")) {
                                            Button(action: {
                                                
                                                if reachability?.connection == .unavailable {
                                                    
                                                    noInternet.toggle()
                                                    do {
                                                        try vm.downloadFieldJSON(teamnumber: teamNumber, matchNumber: matchNumber, matchType: matchType, autoLowCube: autoLowCube, autoMidCube: autoMidCube, autoHighCube: autoHighCube, autoLowCone: autoLowCone, autoMidCone: autoMidCone, autoHighCone: autoHighCone, teleopLowCube: teleopLowCube, teleopMidCube: teleopMidCube, teleopHighCube: teleopHighCube, teleopLowCone: teleopLowCone, teleopMidCone: teleopMidCone, teleopHighCone: teleopHighCone, autoChargeStationPts: autoChargeStation, endgame: chargeStation)
                                                    } catch {
                                                        print(error)
                                                        noFileSystem.toggle()
                                                    }
                                                } else {
                                                    vm.addMatchData(teamNumber: teamNumber, matchNumber: matchNumber, matchType: matchType, autoLowCube: autoLowCube, autoMidCube: autoMidCube, autoHighCube: autoHighCube, autoLowCone: autoLowCone, autoMidCone: autoMidCone, autoHighCone: autoHighCone, teleopLowCube: teleopLowCube, teleopMidCube: teleopMidCube, teleopHighCube: teleopHighCube, teleopLowCone: teleopLowCone, teleopMidCone: teleopMidCone, teleopHighCone: teleopHighCone, autoChargeStationPts: autoChargeStation, endgame: chargeStation)
                                                    pushAlert.toggle()
                                                    do {
                                                        try vm.downloadFieldJSON(teamnumber: teamNumber, matchNumber: matchNumber, matchType: matchType, autoLowCube: autoLowCube, autoMidCube: autoMidCube, autoHighCube: autoHighCube, autoLowCone: autoLowCone, autoMidCone: autoMidCone, autoHighCone: autoHighCone, teleopLowCube: teleopLowCube, teleopMidCube: teleopMidCube, teleopHighCube: teleopHighCube, teleopLowCone: teleopLowCone, teleopMidCone: teleopMidCone, teleopHighCone: teleopHighCone, autoChargeStationPts: autoChargeStation, endgame: chargeStation)
                                                    } catch {
                                                        print(error)
                                                        noFileSystem.toggle()
                                                    }
                                                }
                                                
                                            }, label: {
                                                Text("Confirm Data")
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 75.0)
                                                    .background(Color(hex: "2c9c00"))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(8)
                                                    .bold()
                                                    .padding(.horizontal, 20)
                                            })
                                            .alert("Data pushed!", isPresented: $pushAlert) {
                                                Button("OK", role: .cancel) {
                                                    reviewSheet.toggle()
                                                }
                                            }
                                            .alert("No Internet! Data saved to document directoy. Attempt to push again when you have a valid connection", isPresented: $noInternet) {
                                                Button("OK", role: .cancel) {}
                                            }
                                            .alert("An error with saving data to document directory!", isPresented: $noFileSystem) {
                                                Button("OK", role: .cancel) {}
                                            }
                                        }
                                    }
                                    
                                }
                                .navigationTitle("Review Data")
                            }
                        }
                    }
                    Section(header: Text("Get outta here")) {
                        NavigationLink(destination: HomepageView().navigationBarBackButtonHidden(true)) {
                            Text("Back Home")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50.0)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
            .navigationTitle("TeleOp period - \(teamNumber)")
        }
    }
}

struct teleopForm_Previews: PreviewProvider {
    static var previews: some View {
        teleopForm(matchType: "Qualifier", matchNumber: "69", teamNumber: "4255", autoLowCube: 0, autoMidCube: 0, autoHighCube: 0, autoLowCone: 0, autoMidCone: 0, autoHighCone: 0, teleopLowCube: 0, teleopMidCube: 0, teleopHighCube: 0, teleopLowCone: 0, teleopMidCone: 0, teleopHighCone: 0, autoChargeStation: 0)
    }
}
