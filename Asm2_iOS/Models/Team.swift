/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The model for an individual landmark.
*/

import SwiftUI

struct Team: Hashable, Codable, Identifiable {
    var id: String
    var details: TeamDetail
}

struct TeamDetail: Hashable, Codable {
    var fullname: String
    var leaderboardName: String
    var teamWebsite: String
    var stadium: Stadium
}

struct Stadium: Hashable, Codable {
    var stadiumName: String
    var capacity: Int
}

extension Team {
    var teamIcon: Image {
        ImageStore.shared.image(name: details.leaderboardName)
    }
}
