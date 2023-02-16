//
//  offlinePitDataView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/16/23.
//

import SwiftUI

struct offlinePitDataView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var files: [URL] = []
    var body: some View {
        NavigationStack {
            ZStack {
                if !files.isEmpty {
                    List {
                        ForEach(files, id: \.self) { file in
                            
                            NavigationLink(destination: advancedPitDataView(team: file)) {
                                
                                let team = vm.decodePitData(file: file)
                                
                                let i = String(team.teamnumber)
                                
                                Text("**\(i)**\n\(file.lastPathComponent)")
                            }
                            
                        }
                        
                    }
                    .listStyle(.plain)
                    .navigationTitle("Teams")
                } else {
                    Text("No data to be uploaded!")
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
