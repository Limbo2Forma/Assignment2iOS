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
var orderedTeams = orderPlacement()

var currentRound = getCurrrentRound()
var currentMatches = groupByDate(round: getCurrrentRound())

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
    
    let calendar = Calendar.current
    let matchDate = calendar.date(byAdding: .hour, value: 7, to: dateFormatter.date(from:info[1])!)
    
    var match = Match(
        id: UUID(),
        round: Int(info[0])!,
        homeTeam: teamsData.first(where: {$0.id == info[3]})!,
        awayTeam: teamsData.first(where: {$0.id == info[4]})!,
        homeScore: -1,
        awayScore: -1,
        matchDate: matchDate!
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

func getCurrrentRound() -> Int {
    let today = Date()
    for match in matchesData {
        if match.matchDate > today {
            return match.round
        }
    }
    return 38
}

struct MatchSection: Hashable {
    var key: String
    var value: [Match]
}

func groupByDate(round: Int) -> Array<MatchSection> {
    
    let matches = matchesData.filter { $0.round == round }
    let dateToStr = DateFormatter()
    dateToStr.dateFormat = "EEEE, MMM d, yyyy"
    
    var sections = [MatchSection]()
    var section = MatchSection(key: "", value: [])
    var prevStr = "1"
    var str = ""
    
    for m in matches {
        str = dateToStr.string(from: m.matchDate)
        if str != prevStr {
            sections.append(section)
            section.key = str
            section.value = [m]
        }
        else {
            section.value.append(m)
        }
        prevStr = str
    }
    sections.removeFirst()
    sections.append(section)
    print(sections)
    return sections
}


