import SwiftUI

struct CalendarView: View {
    
    @State var currenrDate: Date = Date()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing:20){
                
                // custom date picker
                CustomDatePicker(currentDate:  $currenrDate)
            }
            .padding(.vertical, 10)
        }
        //safe Area view
        .safeAreaInset(edge: .bottom) {
            HStack{
                
                Button{
                    
                } label: {
                    Text("Add Task")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Orange"), in: Capsule())
                }
                
                Button{
                    
                } label: {
                    Text("Reminder")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Purple"), in: Capsule())
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 10)
            .foregroundColor(.white)
            .opacity(0.5)
            .background(.ultraThinMaterial)
        }
    }
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
