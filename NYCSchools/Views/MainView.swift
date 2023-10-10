//
//  ContentView.swift
//  NYCSchools
//
//  Created by yining zha on 10/10/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.schools) { school in
                NavigationLink(destination: DetailView(school: school)) {
                    
                        Text(school.school_name)

                }
            }
            .navigationTitle("NYC Schools")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
