/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view showing a list of landmarks.
*/

import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                LeaderboardHeader()
                ScrollView(showsIndicators: false) {
                    ForEach(orderedTeams.indices) { i in NavigationLink(destination: TeamDetailsView(team: orderedTeams[i])) {
                            LeaderboardRow(team: orderedTeams[i], position: i)
                        }
                    }
                }
            }
        }
    }
}

struct LeaderboardHeader: View {
    var body: some View {
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
        .background(Color.gray)
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
