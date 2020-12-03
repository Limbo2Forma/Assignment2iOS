import SwiftUI

struct ScheduleView: View {
    
    var body: some View {
        VStack {
            Text(String(currentRound))
                .font(.headline)
            List{
                ForEach(currentMatches, id: \.self) { section in
                    Section(header: Text(section.key)) {
                        ForEach(section.value, id: \.self) { m in
                            ScheduleRow(match: m)
                        }
                    }
                }
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
