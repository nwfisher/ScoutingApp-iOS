//
//  offlineView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/9/23.
//

import SwiftUI

struct offlineView: View {
    
    let vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink(destination: offlinePitDataView()) {
                        Text("Pit Data")
                    }
                    NavigationLink(destination: offlineFieldDataView()) {
                        Text("Field Data")
                    }
                }
            }
        }
    }
    
}

struct offlineView_Previews: PreviewProvider {
    static var previews: some View {
        offlineView()
    }
}
