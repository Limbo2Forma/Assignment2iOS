import SwiftUI

struct TeamDetailsView: View {
    var team: Team

    var body: some View {
        ScrollView(showsIndicators: false) {
            team.details.stadium.image
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
            ShowTeamName(team: team)
                .padding(.leading, 15.0)
            Divider()
            ShowStadiumInfo(stadium: team.details.stadium)
            Spacer()
        }
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
            Text(stadium.stadiumName)
                .font(.title)
                .frame(height: 50)

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
                Text(stadium.description)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding(.leading, 15.0)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(team: teamsData[1])
    }
}
