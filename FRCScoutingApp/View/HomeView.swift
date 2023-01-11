//
//  HomeView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/5/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var temp = false
    @State var searchText = ""
    var body: some View {
      
        VStack {
        /*    ZStack {
                Color(hex: "#2c9c00").ignoresSafeArea()
                
                HStack{
                    //Profile Picture Image
                    Image( "6623BA4C-73C7-444C-AA45-2B402A36904A_1_105_c")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 75.0)
                        .clipShape(Circle())
                        .padding(.leading)
                    
                    //Welcome User
                    Text("Welcome, Nick!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(0.0)
                        .foregroundColor(Color(hex: "#FDDA24"))
                        
                    
                    
                }
                
            }
            //Set frame height of Colored Bar
            //.frame(height: 100)*/
            
            //Create list of events
            NavigationStack {
                List {
                    NavigationLink(destination: MBRView()) {
                        Text("Monterey Bay Regional")
                    }
                    NavigationLink(destination: SVRView()) {
                        Text("Silicon Valley Regional")
                    }
                    
                }
                .navigationTitle("Events")
                
             
                
            }
            
            //Link to Blue Alliance
            Link("The Blue Alliance", destination: URL(string: "https://www.thebluealliance.com")!)
                .fontWeight(.bold)
                .font(.title3)
                .padding()
                Spacer()
            
        }
    }
}
    
    
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Allow for use of HEX Colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

