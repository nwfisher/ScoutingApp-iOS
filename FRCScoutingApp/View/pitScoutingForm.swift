//
//  pitScoutingForm.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import SwiftUI

struct pitScoutingForm: View {
    @State private var showingAlert = false
    
    
    var Events = ["Monterey Bay Regional", "Silicon Valley Regional", "Select Option"]
    @State private var selectedEvent = "Select Option"
    @State private var teamNumber = ""
    @State private var drivetrainType = ""
    @State private var motorType = ""
    @State private var programmingLanguage = ""
    @State private var canPlaceLow = false
    @State private var canPlaceMid = false
    @State private var canPlaceHigh = false
    @State private var canPickCone = false
    @State private var canPickCube = false
    @State private var canPickFallenCones = false
    @State private var cycleTimes = ""
    @State private var canPickFromGround = false
    @State private var canPickFromShelf = false
    
    
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
                        
                    }
                    Section(header: Text("Team Information")) {
                        TextField("Team Number", text: $teamNumber)
                    }
                    Section(header: Text("Robot information")) {
                        
                        TextField("Drivetrain Type", text: $drivetrainType)
                        
                        TextField("Motor type", text: $motorType)
                        
                        TextField("Programming Language", text: $programmingLanguage)
                    }
                    Section(header: Text("Intaking Game Elements")) {
                        Toggle(isOn: $canPickCone) {
                            Text("Can intake cone")
                        }
                        
                        Toggle(isOn: $canPickCube) {
                            Text("Can intake cube")
                        }
                        
                        Toggle(isOn: $canPickFallenCones) {
                            Text("Can intake fallen cones")
                        }
                    }
                    Section(header: Text("Scoring heights")) {
                        Toggle(isOn: $canPlaceLow) {
                            Text("Low")
                        }
                        
                        Toggle(isOn: $canPlaceMid) {
                            Text("Mid")
                        }
                        
                        Toggle(isOn: $canPlaceHigh) {
                            Text("High")
                        }
                        
                    }
                    Section(header: Text("Pickup Locations")) {
                        Toggle(isOn: $canPickFromShelf) {
                            Text("Shelf")
                        }
                        
                        Toggle(isOn: $canPickFromGround) {
                            Text("Ground")
                        }
                    }
                    Section(header: Text("Cycle Time")) {
                        TextField("Cycle Time", text: $cycleTimes)
                    }
                        Button(action: {
                            showingAlert = true
                            //The really annoying part of encoding this bitch
                        }, label: {
                            Text("Submit")
                                .frame(maxWidth: .infinity,  alignment: .center)
                                .frame(height: 50.0)
                                .background( Color(hex: "#2c9c00"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        })
                        .alert("Submitted data, feel free to return.", isPresented: $showingAlert) {
                                  Button("OK", role: .cancel) { }
                              }

                    
                }
            }
            .navigationTitle("Pit Scouting Form")
        }
    }
}

struct pitScoutingForm_Previews: PreviewProvider {
    static var previews: some View {
        pitScoutingForm()
    }
}

