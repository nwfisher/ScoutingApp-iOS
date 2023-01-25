//
//  SettingsView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/16/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingAlert = false
    @State private var accessDenied = false
    @State private var resetData = false
    @State private var adminPass = ""
    @StateObject private var vm = MBRTeamViewModel()
    var body: some View {
        Text("Under construction 🚧")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
