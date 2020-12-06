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
    Set transparent background for a Listview: https://stackoverflow.com/questions/59054848/swift-set-clear-background-color-in-uitableview
    Sections in SwiftUI: https://medium.com/swift-programming/swift-enums-and-uitableview-sections-1806b74b8138
*/

import SwiftUI

struct ScheduleView: View {
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Matchweek " + String(currentRound))
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image("EPL")
                    .resizable()
                    .frame(width: 120.0, height: 80.0)
                Spacer()
            }
            .padding(.vertical, -12.5)
            
            List{
                ForEach(currentMatches, id: \.self) { section in
                    Section(header: Text(section.key)) {
                        ForEach(section.value, id: \.self) { m in
                            ScheduleRow(match: m)
                                .background(Color.clear)
                        }
                    }
                    .background(Color.clear)
                }
            }
            // set the list background to transparent
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            })
            
        }
        // add translucent image background
        .background(Image("bg1").resizable().opacity(0.07))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
