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
    SwiftUI equal width subviews: https://stackoverflow.com/questions/56620499/equal-widths-of-subviews-with-swiftui
    Conditional view in SwiftUI: https://stackoverflow.com/questions/56517610/conditionally-use-view-in-swiftui
    Set transparent background for ListView element: https://stackoverflow.com/questions/59054848/swift-set-clear-background-color-in-uitableview
*/

import SwiftUI

struct ScheduleRow: View {
    var match: Match
    var body: some View {
        VStack{
            // show match date
            Text(String(dateFormatter.string(from: match.matchDate)).components(
                separatedBy: " "
            )[1])
                .padding(.bottom, -10.0)
                .font(.system(size: 18))
            
            // show match info
            HStack{
                
                // show home team name and icon
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
                
                // show score if match completed or show nothing if match not completed yet
                ShowScore(match: match)
                    .font(.system(size: 28))
                    .frame(minWidth: 0, maxWidth: 76)
                
                // show away team name and icon
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
        // set row element of list is transparent background
        .listRowBackground(Color.clear)
    }
}

struct ShowScore: View {
    var match: Match
    var body: some View {
        // check for match score if available
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
