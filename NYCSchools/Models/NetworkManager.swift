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
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTask(with: getNycSchoolsUrl) { nycSchoolsData, _, _ in
            guard let nycSchoolsData = nycSchoolsData, let nycSchoolsList = try? decoder.decode([CombinedSchool].self, from: nycSchoolsData) else {
                print("Error decoding data from NYC Schools URL")
                return
            }

            URLSession.shared.dataTask(with: self.getSatScoresUrl) { satScoresData, _, _ in
                guard let satScoresData = satScoresData, let satScoresList = try? decoder.decode([CombinedSchool].self, from: satScoresData) else {
                    print("Error decoding data from SAT Scores URL")
                    return
                }

                let combined = nycSchoolsList.map { nycSchoolsList -> CombinedSchool in
                    if let matchedSatScore = satScoresList.first(where: { $0.dbn == nycSchoolsList.dbn }) {
                        return CombinedSchool(dbn: nycSchoolsList.dbn,
                                              schoolName: nycSchoolsList.schoolName,
                                              satMathAvgScore: matchedSatScore.satMathAvgScore,
                                              satCriticalReadingAvgScore: matchedSatScore.satCriticalReadingAvgScore,
                                              satWritingAvgScore: matchedSatScore.satWritingAvgScore)
                    }
                    return nycSchoolsList
                }

                DispatchQueue.main.async {
                    self.schools = combined
                }
            }.resume()
        }.resume()
    }
}
