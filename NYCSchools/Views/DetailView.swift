//
//  DetailView.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import SwiftUI

struct DetailView: View {
    let school: CombinedSchool

    var body: some View {
        VStack(spacing: 20) {
            Text(school.school_name)
                .font(.system(size: 26))
                .padding()
                .padding(.top, 50)
                .bold()
            

            VStack(alignment: .leading, spacing: 10) {
                Text("· Math Avg Score: \(school.sat_math_avg_score ?? "N/A")")
                Text("· Critical Reading Avg Score: \(school.sat_critical_reading_avg_score ?? "N/A")")
                Text("· Writing Avg Score: \(school.sat_writing_avg_score ?? "N/A")")
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle("SAT Scores", displayMode: .inline)
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(school: CombinedSchool(dbn: "123456",
                                           school_name: "Sample High School",
                                           sat_math_avg_score: "520",
                                           sat_critical_reading_avg_score: "530",
                                           sat_writing_avg_score: "540"))
    }
}

