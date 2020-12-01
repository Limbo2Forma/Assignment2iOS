//
//  List.swift
//  EPL
//
//  Created by Nam, Vu Hai on 12/1/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

let teamsData: [Team] = load("teams.json")
let dateFormatter = DateFormatter()
let matchesData: [Match] = parseCSV()
var teamsDict = [Team: TeamStats]()

func updateStats(oldStats: TeamStats, teamScore: Int, opponentScore: Int) -> TeamStats {
    // update the goalFor and goalAgainst
    var newStats = oldStats
    
    newStats.goalFor = newStats.goalFor + teamScore
    newStats.goalAgainst = newStats.goalAgainst + opponentScore
    
    // update the win/draw/loss, also updating the last 5 matches result
    if (teamScore > opponentScore) {
        newStats.win = newStats.win + 1
    }
    if (teamScore == opponentScore) {
        newStats.draw = newStats.draw + 1
    }
    if (teamScore < opponentScore) {
        newStats.lost = newStats.lost + 1
    }
    
    return newStats
}

func parseMatch(matchStr: String) -> Match {
    
    var matchStrCopy = matchStr
    matchStrCopy.removeLast()
    let info = matchStrCopy.components(separatedBy: ",")
    
    var match = Match(
        id: UUID(),
        round: Int(info[0])!,
        homeTeam: teamsData.first(where: {$0.id == info[3]})!,
        awayTeam: teamsData.first(where: {$0.id == info[4]})!,
        homeScore: -1,
        awayScore: -1,
        matchDate: dateFormatter.date(from:info[1])!
    ) 
    
    if info[5].count > 2 {
        // get the stats from the match
        match.homeScore = Int(info[5].components(separatedBy: " - ")[0])!
        match.awayScore = Int(info[5].components(separatedBy: " - ")[1])!
        
        var homeTeamStats = TeamStats()
        if let stats = teamsDict[match.homeTeam] {
            homeTeamStats = stats
        }
        homeTeamStats = updateStats(oldStats: homeTeamStats, teamScore: match.homeScore, opponentScore: match.awayScore)
        teamsDict[match.homeTeam] = homeTeamStats
        
        var awayTeamStats = TeamStats()
        if let stats = teamsDict[match.awayTeam] {
            awayTeamStats = stats
        }
        awayTeamStats = updateStats(oldStats: awayTeamStats, teamScore: match.awayScore, opponentScore: match.homeScore)
        teamsDict[match.awayTeam] = awayTeamStats
    }
    
    return match
}

func parseCSV() -> [Match] {
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    let matchesString = getCSVData()
    var matches = [Match]()
    
    for m in matchesString {
        matches.append(parseMatch(matchStr: m))
    }
    
    return matches
}

func orderPlacement() -> Array<Team> {
    // first convert to array so it can be sorted
    
    let sorted = teamsDict.sorted { (first, second) -> Bool in
        return (first.value.points > second.value.points) || (first.value.points == second.value.points && first.value.goalDiff < second.value.goalDiff)
    }
    
    return sorted.map { $0.key}
}
