import SwiftUI

struct ScheduleView: View {
    var body: some View {
        Text(matchesData[0].homeTeam.details.fullname)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
