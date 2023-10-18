//
//  NewworkManager.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import Foundation



class NetworkManager: ObservableObject {
    @Published var schools = [CombinedSchool]()
    
    let getNycSchoolsUrl = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
    let getSatScoresUrl = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!
    
    func fetchData() {
        fetchNYCSchools { nycSchoolsList in
            self.fetchSATScores { satScoresList in
                let combined = self.combineData(nycSchools: nycSchoolsList, satScores: satScoresList)
                DispatchQueue.main.async {
                    self.schools = combined
                }
            }
        }
    }
    
    private func fetchNYCSchools(completion: @escaping ([CombinedSchool]) -> Void) {
        fetch(from: getNycSchoolsUrl, completion: completion)
    }
    
    private func fetchSATScores(completion: @escaping ([CombinedSchool]) -> Void) {
        fetch(from: getSatScoresUrl, completion: completion)
    }
    
    private func fetch(from url: URL, completion: @escaping ([CombinedSchool]) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let schools = try? decoder.decode([CombinedSchool].self, from: data) else {
                print("Error decoding data from \(url)")
                return
            }
            completion(schools)
        }.resume()
    }
    
    private func combineData(nycSchools: [CombinedSchool], satScores: [CombinedSchool]) -> [CombinedSchool] {
        return nycSchools.map { nycSchool -> CombinedSchool in
            if let matchedSatScore = satScores.first(where: { $0.dbn == nycSchool.dbn }) {
                return CombinedSchool(dbn: nycSchool.dbn,
                                      schoolName: nycSchool.schoolName,
                                      satMathAvgScore: matchedSatScore.satMathAvgScore,
                                      satCriticalReadingAvgScore: matchedSatScore.satCriticalReadingAvgScore,
                                      satWritingAvgScore: matchedSatScore.satWritingAvgScore)
            }
            return nycSchool
        }
    }
}
