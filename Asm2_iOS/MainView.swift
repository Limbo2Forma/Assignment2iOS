//
//  SwiftUIView.swift
//  Landmarks
//
//  Created by Nam, Vu Hai on 11/30/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ScheduleView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("Schedule")
                }
            LeaderboardView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Table")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
