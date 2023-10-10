//
//  NewworkManager.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import Foundation



class NetworkManager: ObservableObject {
    @Published var schools = [CombinedSchool]()

    let url1 = URL(string: "https://data.cityofnewyork.us/resource/s3k6-pzi2.json")!
    let url2 = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json")!

    func fetchData() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        URLSession.shared.dataTask(with: url1) { data1, _, _ in
            guard let data1 = data1, let schools1 = try? decoder.decode([CombinedSchool].self, from: data1) else {
                print("Error decoding data from URL1")
                return
            }

            URLSession.shared.dataTask(with: self.url2) { data2, _, _ in
                guard let data2 = data2, let schools2 = try? decoder.decode([CombinedSchool].self, from: data2) else {
                    print("Error decoding data from URL2")
                    return
                }

                let combined = schools1.map { school1 -> CombinedSchool in
                    if let matchedSchool2 = schools2.first(where: { $0.dbn == school1.dbn }) {
                        return CombinedSchool(dbn: school1.dbn,
                                              schoolName: school1.schoolName,
                                              satMathAvgScore: matchedSchool2.satMathAvgScore,
                                              satCriticalReadingAvgScore: matchedSchool2.satCriticalReadingAvgScore,
                                              satWritingAvgScore: matchedSchool2.satWritingAvgScore)
                    }
                    return school1
                }

                DispatchQueue.main.async {
                    self.schools = combined
                }
            }.resume()
        }.resume()
    }
}
