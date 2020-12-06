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
    Read json and images: https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
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
    var location: String
    var capacity: Int
    var stadiumImage: String
    var description: String
}

extension Team {
    var teamIcon: Image {
        ImageStore.shared.image(name: "icons/" + details.leaderboardName)
    }
}

extension Stadium {
    var image: Image {
        ImageStore.shared.image(name: "stadiums/" + stadiumImage)
    }
}
