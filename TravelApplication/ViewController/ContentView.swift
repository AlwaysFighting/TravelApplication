import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    
    @AppStorage("log_Status") var log_Status = false
    @State var user = Auth.auth().currentUser
    
    var body: some View{
        if log_Status{
            NavigationView{
                TabUIView()
                // 로그아웃
                VStack(spacing: 15){
                    Text("Logged In")
                    
                    Button("Logout"){
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        
                        withAnimation{
                            log_Status = false
                        }
                    }
                }
            }
        }else{
            LoginView()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct mainHome: View{
    var body: some View{
        NavigationView{
            TabUIView()
        }
    }
}
}
