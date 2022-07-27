import SwiftUI

struct TabUIView: View {
    @AppStorage("log_Status") var log_status = false

    var body: some View {
    
            TabView{
                HomeView()
                    .edgesIgnoringSafeArea(.top)
                    .tabItem(){
                            Image(systemName: "house")
                            Text("홈")
                 }
        
                ExpenseView()
                    .tabItem(){
                            Image(systemName: "creditcard")
                            Text("지출")
                    }
                
                CalendarView()
                    .tabItem(){
                            Image(systemName: "calendar.badge.clock")
                            Text("할 일")
                }
                
                DiaryView()
                    .tabItem(){
                        Image(systemName: "square.and.pencil")
                        Text("다이어리")
                }
                
                UserView()
                    .tabItem(){
                            Image(systemName: "person.fill")
                            Text("마이페이지")
                }
             }
            .accentColor(.indigo)
    }
}

struct TabUIView_Previews: PreviewProvider {
    static var previews: some View {
        TabUIView()
    }
}
