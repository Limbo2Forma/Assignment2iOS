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
                Image("EPL").resizable()
                    .frame(width: 120.0, height: 80.0)
                Spacer()
            }
            .padding(.vertical, -20.0)
            
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
