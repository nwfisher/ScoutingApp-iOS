//
//  MBRTeamViewModel.swift
//  FRCScoutingApp
//
//  Created by Nicolas Fisher on 1/10/23.
//

import Foundation

final class MBRTeamViewModel: ObservableObject {
    
    @Published var MBRTeams: [MBRTeam] = []
    func fetchUsers () {
        let url = URL(string: "https://www.thebluealliance.com/api/v3/event/2023camb/teams")!
        var request = URLRequest(url: url)
        
        request.addValue("eC94U6j5wAui6S7IFdgHLgxVQ4lUw2EUOm3EkzdC6VDS0Hd80efGBf5SKrPymOWa", forHTTPHeaderField: "X-TBA-Auth-Key")
        
            URLSession
                    .shared
                    .dataTask(with: request) { [weak self] data, response, error in
                        
                        DispatchQueue.main.async {
                            if error == nil {
                                
                                let decoder = JSONDecoder()
                                JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
                                
                                if let data = data,
                                let teams = try? decoder.decode ([MBRTeam].self, from: data) {
                                
                                    self?.MBRTeams = teams
                                } else {
                                    
                                }
                            }
                        }
                       
                    }.resume()
        
    }
}
