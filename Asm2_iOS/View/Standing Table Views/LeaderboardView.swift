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
    NavigationView in SwiftUI: https://www.hackingwithswift.com/articles/216/complete-guide-to-navigationview-in-swiftui
*/

import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                LeaderboardHeader()
                // Scrollview with hiddent indicators
                ScrollView(showsIndicators: false) {
                    ForEach(orderedTeams.indices) { i in NavigationLink(destination: TeamView(team: orderedTeams[i])) {
                            LeaderboardRow(team: orderedTeams[i], position: i)
                        }
                    }
                }
            }
            .background(Image("bg1").resizable().opacity(0.07))
            .navigationBarHidden(true)
        }
    }
}

struct LeaderboardHeader: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Leaderboard")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image("EPL")
                    .resizable()
                    .frame(width: 120.0, height: 80.0)
                Spacer()
            }
            .padding(.top, -20.0)
        }
        .background(Color.clear)
        HStack() {
            HStack(alignment: .top) {
                Text("POS")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                    .frame(width: 30)
                Text("CLUB")
                    .font(.system(size: 12))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            HStack {
                Spacer()
                Text("PL")
                    .font(.system(size: 12))
                    .frame(width: 19)
                Text("W")
                    .font(.system(size: 12))
                    .frame(width: 19)
                Text("D")
                    .frame(width: 19)
                    .font(.system(size: 12))
                Text("L")
                    .frame(width: 19)
                    .font(.system(size: 12))
                Text("GD")
                    .frame(width: 21)
                    .font(.system(size: 12))
                Text("Pts")
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .frame(width: 21)
            }

            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.trailing, 5.0)
        }
        .frame(height: 30.0)
        .background(Color(UIColor.systemGray4))
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11"], id: \.self) { deviceName in
            LeaderboardView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
