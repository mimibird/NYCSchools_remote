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
            Text(school.schoolName)
                .font(.system(size: 26))
                .padding()
                .padding(.top, 50)
                .bold()
            

            VStack(alignment: .leading, spacing: 10) {
                Text("· Math Avg Score: \(school.satMathAvgScore ?? "N/A")")
                Text("· Critical Reading Avg Score: \(school.satCriticalReadingAvgScore ?? "N/A")")
                Text("· Writing Avg Score: \(school.satWritingAvgScore ?? "N/A")")
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
                                          schoolName: "Sample High School",
                                          satMathAvgScore: "520",
                                          satCriticalReadingAvgScore: "530",
                                          satWritingAvgScore: "540"))
    }
}

