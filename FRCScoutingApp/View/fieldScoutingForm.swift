//
//  fieldScoutingForm.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/12/23.
//

import SwiftUI

struct fieldScoutingForm: View {
    
    @State private var showingAlert = false
    
    let MBRvm = MBRTeamViewModel()
    let SVRvm = SVRTeamViewModel()
    var Events = ["Monterey Bay Regional", "Silicon Valley Regional", "Select Option"]
    var matchTypes = [
        "Quali",
        "Quarterfinals",
        "Semifinals"
    ]
    var autoChargeStationPositions = [
        "MOBILITY",
        "DOCKED",
        "DOCKED and ENGAGED"
    ]
    
    var endgameChargeStationPositions = [
        "PARK",
        "DOCKED",
        "DOCKED and ENGAGED"
    ]
    var defenseSkillLevel = [
        "Limited",
        "Decent",
        "Good",
        "Great",
        "Elite"
    ]
 
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedEvent = "Select Option"
    @State private var selectedMatchType = "Quali"
    @State private var autoChargeStationComplete = ""
    @State private var teamNumber = ""
    @State private var matchNumber = ""
    @State private var autoCyclesCompleted = ""
    @State private var autoLevelsReached = ""
    @State private var teleopCyclesCompleted = ""
    @State private var teamDefenseSkill = ""
    @State private var opponentDefenseSkill = ""
    @State private var opponentTeam = ""
    @State private var teamDefendedAgainst = ""
    @State private var teleopReachedL1 = false
    @State private var teleopReachedL2 = false
    @State private var teleopReachedL3 = false
    @State private var defended = false
    @State private var teamPlayedDefense = false
    @State private var endgameChargeStation = ""
    @State private var notes = ""
    var body: some View {
            NavigationStack {
                VStack {
                    Form {
                        Section(header: Text("Event")) {
                            Picker("Please choose an Event", selection: $selectedEvent) {
                                ForEach(Events, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                            
                            Picker("Please choose a Match Type", selection: $selectedMatchType) {
                                
                                
                                ForEach(matchTypes, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                            
                            TextField("Match Number", text: $matchNumber)
                        }
                        
                        
                        
                        Section(header: Text("Team Information")) {
                            
                            TextField("Team Number", text: $teamNumber)
                        }
                        
                        Section(header: Text("Autonomous Period")) {
                            
                            TextField("Auto cycles completed", text: $autoCyclesCompleted)
                            TextField("Levels reached", text: $autoLevelsReached)
                            Picker("Charge Station Status", selection: $autoChargeStationComplete) {
                                
                                Text("").tag("")
                                
                                ForEach(autoChargeStationPositions, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                          
                        }
                        Section(header: Text("Teleop Period")) {
                            TextField("Cycles completed", text: $teleopCyclesCompleted)
                            Toggle(isOn: $teleopReachedL1) {
                                Text("Reached L1")
                            }
                            Toggle(isOn: $teleopReachedL2) {
                                Text("Reached L2")
                            }
                            Toggle(isOn: $teleopReachedL3) {
                                Text("Reached L3")
                            }
                            

                        }
                        Section(header: Text("Team Defense \n(disregard if team did not play Defense)")) {
                            Toggle(isOn: $teamPlayedDefense) {
                                Text("Team Played Defense")
                            }
                            
                            Picker("Team Defense Skill", selection: $teamDefenseSkill) {
                                
                                Text("").tag("")
                                
                                ForEach(defenseSkillLevel, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                            TextField("Defended against", text: $teamDefendedAgainst)
                        }
                        Section(header: Text("Defended\n(Disregard if team was not defended")) {
                            Toggle(isOn: $defended) {
                                Text("Team was defended")
                            }
                            
                            TextField("Team was defended by", text: $opponentTeam)
                            
                            Picker("Defense Skill", selection: $opponentDefenseSkill) {
                                
                                Text("").tag("")
                                
                                ForEach(defenseSkillLevel, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                        }
                        Section(header: Text("Endgame")) {
                            Picker("Charge Station", selection: $endgameChargeStation) {
                                
                                Text("").tag("")
                                
                                ForEach(endgameChargeStationPositions, id: \.self) {
                                    Text($0)
                                }
                                
                            }
                        }
                        Button(action: {
                            showingAlert = true
                            //Very dumv long else if statement
                            if selectedEvent == "Monterey Bay Regional" {
                                MBRvm.addMatchData(teamnumber: teamNumber, matchnumber: matchNumber, matchType: selectedMatchType, autoChargeStationComplete: autoChargeStationComplete, autoCyclesCompleted: autoCyclesCompleted, autoLevelsReached: autoLevelsReached, teleopCyclesCompleted: teleopCyclesCompleted, teamDefenseSkill: teamDefenseSkill, opponentDefenseSkill: opponentDefenseSkill, opponentTeam: opponentTeam, teamDefendedAgainst: teamDefendedAgainst, teleopReachedL1: teleopReachedL1, teleopReachedL2: teleopReachedL2, teleopReachedL3: teleopReachedL3, defended: defended, teamPlayedDefense: teamPlayedDefense, endgameChargeStation: endgameChargeStation, notes: notes)
                            } else if selectedEvent == "Silicon Valley Regional" {
                               //DO nothing
                            } else {
                               print("An error has occured")
                            }
                        }, label: {
                            Text("Submit")
                                .frame(maxWidth: .infinity,  alignment: .center)
                                .frame(height: 50.0)
                                .background( Color(hex: "#2c9c00"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })
                        .alert("Data succesfully submitted", isPresented: $showingAlert) {
                                  Button("OK", role: .cancel) {
                                      dismiss()
                                  }
                              }
                        
                    }
                    
                    .navigationTitle("Field Scouting Form")
                }
            }
    }
}

struct fieldScoutingForm_Previews: PreviewProvider {
    static var previews: some View {
        fieldScoutingForm()
    }
}
