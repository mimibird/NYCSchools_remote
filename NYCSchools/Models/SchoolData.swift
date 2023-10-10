//
//  SchoolsData.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import Foundation

struct SchoolDirectory: Decodable {
    let dbn: String
    let school_name: String
}

struct SATScore: Decodable {
    let dbn: String
    let sat_math_avg_score: String
    let sat_critical_reading_avg_score: String
    let sat_writing_avg_score: String
}

struct CombinedSchool: Identifiable {
    var id: String { return dbn }
    let dbn: String
    let school_name: String
    let sat_math_avg_score: String?
    let sat_critical_reading_avg_score: String?
    let sat_writing_avg_score: String?
}
