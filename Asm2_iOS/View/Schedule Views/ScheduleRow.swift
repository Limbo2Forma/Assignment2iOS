//
//  ScheduleRow.swift
//  EPL
//
//  Created by Nam, Vu Hai on 12/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct ScheduleRow: View {
    var match: Match
    var body: some View {
        VStack{
            Text(String(dateFormatter.string(from: match.matchDate)).components(
                separatedBy: " "
            )[1])
                .padding(.bottom, -10.0)
                .font(.system(size: 18))
            HStack{
                HStack {
                    Spacer()
                    Text(match.homeTeam.id)
                        .font(.system(size: 14))
                        .lineLimit(2)
                    match.homeTeam.teamIcon
                        .resizable()
                        .frame(width: 42, height: 42)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                ShowScore(match: match)
                    .font(.system(size: 28))
                    .frame(minWidth: 0, maxWidth: 76)
                HStack {
                    match.awayTeam.teamIcon
                        .resizable()
                        .frame(width: 42, height: 42)
                    Text(match.awayTeam.id)
                        .font(.system(size: 14))
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
            }
            Text(match.homeTeam.details.stadium.stadiumName)
        }
    }
}

struct ShowScore: View {
    var match: Match
    var body: some View {
        if match.homeScore != -1 {
            HStack {
                Text(String(match.homeScore))
                    .fontWeight(.bold)
                Text("-")
                    .fontWeight(.heavy)
                Text(String(match.awayScore))
                    .fontWeight(.bold)
            }
        } else {
            HStack {
                Text("/")
                Text("-")
                Text("/")
            }
        }
    }
}

struct ScheduleRow_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleRow(match: matchesData[3])
    }
}
