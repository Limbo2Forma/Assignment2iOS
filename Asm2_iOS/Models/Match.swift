//
//  Match.swift
//  Landmarks
//
//  Created by Nam, Vu Hai on 11/30/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Match: Hashable, Codable, Identifiable {
    var id: Int
    var round: Int
    var homeTeam: Team
    var awayTeam: Team
    var homeScore: Int
    var awayScore: Int
    var matchDate: Date
}
