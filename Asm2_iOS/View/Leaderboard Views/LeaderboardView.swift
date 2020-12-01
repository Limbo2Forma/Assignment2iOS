/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        NavigationView {
            List(orderedTeams.indices) { i in
                NavigationLink(destination: TeamDetailsView(team: orderedTeams[i])) {
                    LeaderboardRow(team: orderedTeams[i], position: i)
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
