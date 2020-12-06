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
*/

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
