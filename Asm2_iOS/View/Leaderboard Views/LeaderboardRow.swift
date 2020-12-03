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
            HStack {
                Text(String(position + 1))
                    .font(.system(size: 14))
                    .frame(width: 18)
                team.teamIcon
                    .resizable()
                    .frame(width: 28, height: 28)
                Text(team.details.leaderboardName)
                    .font(.system(size: 15))
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            HStack {
                Spacer()
                Text(String(teamsDict[team]!.matchPlayed))
                    .font(.system(size: 13))
                    .frame(width: 19)
                Text(String(teamsDict[team]!.win))
                    .font(.system(size: 13))
                    .frame(width: 19)
                Text(String(teamsDict[team]!.draw))
                    .frame(width: 19)
                    .font(.system(size: 13))
                Text(String(teamsDict[team]!.lost))
                    .frame(width: 19)
                    .font(.system(size: 13))
                Text(String(teamsDict[team]!.goalDiff))
                    .frame(width: 21)
                    .font(.system(size: 13))
                Text(String(teamsDict[team]!.points))
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .frame(width: 21)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .padding(.all, 5.0)
        .accentColor(Color.black)
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(team: teamsData[0], position: 1)
    }
}
