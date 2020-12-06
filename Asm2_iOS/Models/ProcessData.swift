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
    Spacer tutorial: https://www.ioscreator.com/tutorials/swiftui-spacer-tutorial
    Set system font size Swift: https://developer.apple.com/documentation/uikit/uifont/1619027-systemfont
*/

import SwiftUI

// assign the variable to their appropriate call function, include from the ReadData

// init teams list
let teamsData: [Team] = load("teams.json")

// date formatter to parse date
let dateFormatter = DateFormatter()

// init all matches list
let matchesData: [Match] = parseCSV()

// assign the team to their statistics accordingly
var teamsDict = [Team: TeamStats]()

// sort the team for the leaderboard
var orderedTeams = orderPlacement()

// get current matchweek
var currentRound = getCurrrentRound()

// get all match from current matchweek, divided to sub array by day occur
var currentMatches = groupByDate(round: getCurrrentRound())

// update new stat of a team from a match input
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

// parse the string read from csv file into match info
func parseMatch(matchStr: String) -> Match {
    
    // remove the last \n character, seperate the raw info by ","
    var matchStrCopy = matchStr
    matchStrCopy.removeLast()
    let info = matchStrCopy.components(separatedBy: ",")
    
    // create conversion from GMT to Vietnam time
    let calendar = Calendar.current
    let matchDate = calendar.date(byAdding: .hour, value: 7, to: dateFormatter.date(from:info[1])!)
    
    // init match object
    var match = Match(
        id: UUID(),
        round: Int(info[0])!,
        homeTeam: teamsData.first(where: {$0.id == info[3]})!,
        awayTeam: teamsData.first(where: {$0.id == info[4]})!,
        homeScore: -1,
        awayScore: -1,
        matchDate: matchDate!
    ) 
    
    // if the match result exist, modify the initial match result value
    if info[5].count > 2 {
        
        // get the stats from the match
        match.homeScore = Int(info[5].components(separatedBy: " - ")[0])!
        match.awayScore = Int(info[5].components(separatedBy: " - ")[1])!
        
        // modify the stats of the home team based on the match result
        var homeTeamStats = TeamStats()
        if let stats = teamsDict[match.homeTeam] {
            homeTeamStats = stats
        }
        homeTeamStats = updateStats(oldStats: homeTeamStats, teamScore: match.homeScore, opponentScore: match.awayScore)
        teamsDict[match.homeTeam] = homeTeamStats
        
        // modify the stats of the away team based on the match result
        var awayTeamStats = TeamStats()
        if let stats = teamsDict[match.awayTeam] {
            awayTeamStats = stats
        }
        awayTeamStats = updateStats(oldStats: awayTeamStats, teamScore: match.awayScore, opponentScore: match.homeScore)
        teamsDict[match.awayTeam] = awayTeamStats
    }
    
    return match
}

// parse the string array from the csv file to list of matches
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

// sort teams based on their point and theif goal diff
func orderPlacement() -> Array<Team> {
    // first convert to array so it can be sorted
    
    let sorted = teamsDict.sorted { (first, second) -> Bool in
        return (first.value.points > second.value.points) || (first.value.points == second.value.points && first.value.goalDiff > second.value.goalDiff)
    }
    
    return sorted.map { $0.key }
}

// get current matchweek
func getCurrrentRound() -> Int {
    let today = Date()
    for match in matchesData {
        if match.matchDate > today {
            return match.round
        }
    }
    return 38
}

// structure to sectioning the matches based on date
struct MatchSection: Hashable {
    var key: String
    var value: [Match]
}

// group matches into each sections based on date
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


