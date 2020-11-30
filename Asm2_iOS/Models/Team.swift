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

//
//struct Landmark: Hashable, Codable, Identifiable {
//    var id: Int
//    var name: String
//    fileprivate var imageName: String
//    fileprivate var coordinates: Coordinates
//    var state: String
//    var park: String
//    var category: Category
//
//    var locationCoordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(
//            latitude: coordinates.latitude,
//            longitude: coordinates.longitude)
//    }
//
//    enum Category: String, CaseIterable, Codable, Hashable {
//        case featured = "Featured"
//        case lakes = "Lakes"
//        case rivers = "Rivers"
//    }
//}
//
//extension Landmark {
//    var image: Image {
//        ImageStore.shared.image(name: imageName)
//    }
//}
//
//struct Coordinates: Hashable, Codable {
//    var latitude: Double
//    var longitude: Double
//}
