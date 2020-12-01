/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct LeaderboardRow: View {
    var team: Team
    var position: Int

    var body: some View {
        HStack {
            Text(String(position + 1))
                .font(.system(size: 14))
            team.teamIcon
                .resizable()
                .frame(width: 28, height: 28)
            Text(team.details.leaderboardName)
                .font(.system(size: 15))
            Spacer()
            Text(String(teamsDict[team]!.points))
                .font(.system(size: 14))
            Text(String(teamsDict[team]!.win))
                .font(.system(size: 14))
            Text(String(teamsDict[team]!.draw))
                .font(.system(size: 14))
            Text(String(teamsDict[team]!.lost))
                .font(.system(size: 14))
            Text(String(teamsDict[team]!.goalDiff))
                .font(.system(size: 14))
        }
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(team: teamsData[0], position: 1)
    }
}
