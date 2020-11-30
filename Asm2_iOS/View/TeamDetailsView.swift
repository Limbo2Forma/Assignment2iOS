import SwiftUI

struct TeamDetailsView: View {
    var team: Team

    var body: some View {
        VStack {
            CircleImage(image: team.teamIcon)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text(team.details.fullname)
                    .font(.title)

                HStack(alignment: .top) {
                    Text(team.details.fullname)
                        .font(.subheadline)
                    Spacer()
                    Text(team.details.teamWebsite)
                        .font(.subheadline)
                }
            }
            .padding()

            Spacer()
        }
        .navigationBarTitle(Text(team.id), displayMode: .inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(team: teamsData[0])
    }
}
