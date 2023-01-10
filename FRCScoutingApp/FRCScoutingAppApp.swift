//
//  FRCScoutingAppApp.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/4/23.
//

import SwiftUI
import FirebaseCore



class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()


    return true
  }
}


@main
struct FRCScoutingAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }
    }
}
