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
        URLSession.shared.dataTask(with: url1) { data1, _, _ in
            if let data1 = data1, let schoolDirectories = try? JSONDecoder().decode([SchoolDirectory].self, from: data1) {

                URLSession.shared.dataTask(with: self.url2) { data2, _, _ in
                    if let data2 = data2, let satScores = try? JSONDecoder().decode([SATScore].self, from: data2) {

                        var combinedSchools: [CombinedSchool] = []

                        for school in schoolDirectories {
                            if let score = satScores.first(where: { $0.dbn == school.dbn }) {
                                combinedSchools.append(CombinedSchool(dbn: school.dbn, school_name: school.school_name, sat_math_avg_score: score.sat_math_avg_score, sat_critical_reading_avg_score: score.sat_critical_reading_avg_score, sat_writing_avg_score: score.sat_writing_avg_score))
                            } else {
                                combinedSchools.append(CombinedSchool(dbn: school.dbn, school_name: school.school_name, sat_math_avg_score: nil, sat_critical_reading_avg_score: nil, sat_writing_avg_score: nil))
                            }
                        }

                        DispatchQueue.main.async {
                            self.schools = combinedSchools
                        }
                    }
                }.resume()
            }
        }.resume()
    }
}
