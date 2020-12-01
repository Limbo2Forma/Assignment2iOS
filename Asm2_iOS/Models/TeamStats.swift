//
//  TeamStats.swift
//  EPL
//
//  Created by Nam, Vu Hai on 12/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct TeamStats: Hashable, Codable  {
    var win = 0
    var draw = 0
    var lost = 0
    var goalFor = 0
    var goalAgainst = 0
    
    var goalDiff: Int {
        goalFor - goalAgainst
    }
    
    var points: Int {
        win * 3 + draw
    }
    
    var matchPlayed: Int {
        win + lost + draw
    }
}
