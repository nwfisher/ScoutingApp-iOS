//
//  LaunchView.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 2/14/23.
//

import SwiftUI

struct LaunchView: View {
    // 1.
       @State var isActive:Bool = false
       
       var body: some View {
           VStack {
               // 2.
               if self.isActive {
                   // 3.
                   HomepageView()
               } else {
                   // 4.
                   ZStack {
                       Color(hex: "144600").ignoresSafeArea()
                       Image("Image")
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: .infinity)
                   }
               }
           }
           .onAppear {
               // 6.
               DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                   // 7.
                   withAnimation {
                       self.isActive = true
                   }
               }
           }
       }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
