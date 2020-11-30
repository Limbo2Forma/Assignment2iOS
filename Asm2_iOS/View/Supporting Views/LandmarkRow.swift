/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A single row to be displayed in a list of landmarks.
*/

import SwiftUI

struct LandmarkRow: View {
    var landmark: Team

    var body: some View {
        HStack {
            landmark.teamIcon
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.details.fullname)
            Spacer()
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandmarkRow(landmark: teamsData[0])
            LandmarkRow(landmark: teamsData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
