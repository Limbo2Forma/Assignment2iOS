/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct LeaderboardRow: View {
    var team: Team

    var body: some View {
        HStack {
            team.teamIcon
                .resizable()
                .frame(width: 50, height: 50)
            Text(team.details.leaderboardName)
            Spacer()
            Text(String(teamsDict[team]!.points))
        }
    }
}
