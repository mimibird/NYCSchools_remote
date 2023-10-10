//
//  SchoolsData.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import Foundation

struct CombinedSchool: Decodable, Identifiable {
    let dbn: String
    var id: String { return dbn }
    let schoolName: String
    let satMathAvgScore: String?
    let satCriticalReadingAvgScore: String?
    let satWritingAvgScore: String?
}
