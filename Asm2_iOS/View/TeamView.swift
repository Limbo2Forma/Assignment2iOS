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
    ScrollView: https://swiftwithmajid.com/2020/09/24/mastering-scrollview-in-swiftui/
    Fix text auto truncate bug:  https://swiftwithmajid.com/2020/04/29/the-magic-of-fixed-size-modifier-in-swiftui/
*/

import SwiftUI

struct TeamView: View {
    var team: Team

    var body: some View {
        // scroll view to store the additional view
        ScrollView(showsIndicators: false) {
            
            // team stadium image
            team.details.stadium.image
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
            
            // team names, icons and link
            ShowTeamName(team: team)
                .padding(.leading, 15.0)
            Divider()
            
            // team stadium info
            ShowStadiumInfo(stadium: team.details.stadium)
            
            // team stadium info has to be seperate to fix the text auto truncate bug
            Text(team.details.stadium.description)
                .multilineTextAlignment(.leading)
                .padding(.leading, 15.0)
                .padding(.top, 1.0)
                .lineLimit(999)
                .fixedSize(horizontal: false, vertical: true)
            // additional bottom padding
            Spacer(minLength: 20)
        }
        // set background as translucent image
        .background(Image("bg1").resizable().opacity(0.05))
        // set navigation title
        .navigationBarTitle(Text(team.details.fullname), displayMode: .inline)
    }
}

struct ShowTeamName: View {
    var team: Team
    
    var body: some View {
        HStack {
            team.teamIcon
                .resizable()
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(team.details.fullname)
                    .font(.title)
                // set button go to external link
                Button("Go to official site") {
                    UIApplication.shared.open(URL(string: team.details.teamWebsite)!)
                }
            }
            Spacer()
        }
    }
}

struct ShowStadiumInfo: View {
    var stadium: Stadium
    
    var body: some View {
        VStack {
            // set stadium name, as center align
            Text(stadium.stadiumName)
                .font(.title)
                .frame(height: 50)
                .padding(.top, -10)
            
            // set stadium info, have spacer to set to right align
            VStack(spacing: 5.0) {
                HStack {
                    Text("Location:\t\t")
                        .font(.system(size: 20))
                    Text(stadium.location)
                    Spacer()
                }
                HStack {
                    Text("Capacity:\t\t")
                        .font(.system(size: 20))
                    Text(String(stadium.capacity))
                    Spacer()
                }
                
                HStack {
                    Text("Description:")
                        .font(.system(size: 20))
                    Spacer()
                }
            }
        }
        .padding(.leading, 15.0)
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: teamsData[1])
    }
}
