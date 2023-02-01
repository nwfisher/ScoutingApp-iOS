//
//  matchForm.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/23/23.
//

import SwiftUI

struct autoForm: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var sheetIsPresented = false
    
    let selectedMatchType: String
    let matchNumber: String
    let teamNumber: String
    
    @State var lowCube = 0 //1
    @State var midCube = 0 //2
    @State var highCube = 0 //3
    @State var lowCone = 0 //4
    @State var midCone = 0 //5
    @State var highCone = 0 //6
    
    @State var autoChargeStation = ""
    
    @State var mostRecentVariableChange = ""
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L1 - \(lowCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            lowCube += 1
                            mostRecentVariableChange = "1"
                        }
                        Button(action: {}, label: {
                            Text("Cone L1 - \(lowCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            lowCone += 1
                            mostRecentVariableChange = "4"
                        }
                    }
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L2 - \(midCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            midCube += 1
                            mostRecentVariableChange = "2"
                        }
                        Button(action: {}, label: {
                            Text("Cone L2 - \(midCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            midCone += 1
                            mostRecentVariableChange = "5"
                        }
                    }
                    HStack {
                        Button(action: {}, label: {
                            Text("Cube L3 - \(highCube)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            highCube += 1
                            mostRecentVariableChange = "3"
                        }
                        Button(action: {}, label: {
                            Text("Cone L3 - \(highCone)")
                                .frame(maxWidth: .infinity)
                                .frame(height: 100.0)
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }).onTapGesture {
                            highCone += 1
                            mostRecentVariableChange = "6"
                        }
                    }
                    Button(action: {
                        switch mostRecentVariableChange {
                        case "1":
                            lowCube -= 1
                            mostRecentVariableChange = ""
                        case "2":
                            midCube -= 1
                            mostRecentVariableChange = ""
                        case "3":
                            highCube -= 1
                            mostRecentVariableChange = ""
                        case "4":
                            lowCone -= 1
                            mostRecentVariableChange = ""
                        case "5":
                            midCone -= 1
                            mostRecentVariableChange = ""
                        case "6":
                            highCone -= 1
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
                            autoChargeStation = "Mobility"
                        }, label: {
                            Button(action: {
                                autoChargeStation = "None"
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
                            Text("Mobility")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                                .padding(.horizontal, 20)
                        })
                        Button(action: {
                            autoChargeStation = "Docked"
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
                            autoChargeStation = "Docked & Engaged"
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
                        
                        Text("Selected Status: \(autoChargeStation)")
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
                        NavigationLink(destination: teleopForm(matchType: selectedMatchType, matchNumber: matchNumber, teamNumber: teamNumber, autoLowCube: lowCube, autoMidCube: midCube, autoHighCube: highCube, autoLowCone: lowCone, autoMidCone: midCone, autoHighCone: highCone, autoChargeStation: autoChargeStation)) {
                            Text("Next")
                                .frame(maxWidth: .infinity)
                                .frame(height: 75.0)
                                .background(Color(hex: "2c9c00"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .bold()
                        }.id(UUID()) //this is stupid and hopefully will be fixed someday
                        
                    }
                    
                    Section(header: Text("Match Info")) {
                        Text("Match Type: \(selectedMatchType)")
                        Text("Team Number: \(teamNumber)")
                        Text("Match Number: \(matchNumber)")
                    }
                    
                }
            }
            .navigationTitle("Auto period - \(teamNumber)")
        }
    }
}

struct autoForm_Previews: PreviewProvider {
    static var previews: some View {
        autoForm(selectedMatchType: "Qualifiers", matchNumber: "13", teamNumber: "4255")
    }
}
