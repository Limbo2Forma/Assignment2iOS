/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2020C
  Assessment: Assignment 2
  Author: Vu Hai Nam
  ID: s3694383
  Created  date: 1/12/2020
  Last modified: 7/12/2020
  Acknowledgement:
    The app baseline is from: https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
    Bottom tab view and tab item: https://www.hackingwithswift.com/quick-start/swiftui/adding-tabview-and-tabitem
    Get Appls SF Symbols: https://sfsymbols.com
 */

import SwiftUI

struct HomeView: View {
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
