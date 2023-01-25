//
//  fieldScoutForm.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/23/23.
//

import SwiftUI

struct infoForm: View {
    
    var events = ["Monterey Bay Regional", "Silicon Valley Regional", "Select Option"]
    var matchTypes = ["Quali", "Quarterfinals", "Semifinals"]
    
    @State private var isDisabled = false
    
    @State private var selectedEvent = "Select Option"
    @State private var selectedMatchType = "Quali"
    @State private var matchNumber = ""
    @State private var teamNumber = ""
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("Please choose an Event", selection: $selectedEvent) {
                        ForEach(events, id: \.self) {
                            Text($0)
                        }
                    }
                        Picker("Please choose a Match Type", selection: $selectedMatchType) {
                            ForEach(matchTypes, id: \.self) {
                                Text($0)
                        }
                    }
        
                    TextField("Match Number", text: $matchNumber)
                    TextField("Team Number", text: $teamNumber)
                    
                    
                    if isDisabled {
                        Text("Fill out the form weirdo")
                    } else {
                        Section(header: Text(" ")) {
                            NavigationLink(destination: autoForm(selectedEvent: selectedEvent, selectedMatchType: selectedMatchType, matchNumber: matchNumber, teamNumber: teamNumber).navigationBarBackButtonHidden(true)) {
                                Text("Next")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 75.0)
                                    .background(Color(hex: "2c9c00"))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    .bold()
                            }
                        }
                    }
                }

            }
            .navigationTitle("Match & Team Info")
        }
    }
}

struct infoForm_Previews: PreviewProvider {
    static var previews: some View {
        infoForm()
    }
}
