/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LeaderboardView: View {
    var body: some View {
        NavigationView {
            List(teamsData) { team in
                NavigationLink(destination: TeamDetailsView(team: team)) {
                    LeaderboardRow(team: team)
                }
            }
            .navigationBarTitle(Text("Teams"))
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            LeaderboardView()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
