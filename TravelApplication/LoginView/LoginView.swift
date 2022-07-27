import SwiftUI
import Firebase
import GoogleSignIn

struct LoginView: View {
    
    var body: some View {
        OnBoard()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct GoHome: View{
    var body: some View{
        NavigationView{
            TabUIView()
        }
    }
}

struct OnBoard:View{

    //@State var isLoading:Bool = false
    @State var isLoading: Bool = false
    
    @AppStorage("log_Status") var log_Status = false
    
    @State var onBoard = [
        Board(title: "여행 캘린더", detail: "여행과 관련된 일정을 캘린더에 저장해보세요.", pic: "CalendarAll"),
        Board(title: "여행 가계부", detail: "여행 한도 금액을 설정하고 실제로 든 비용을 차감하여, 여행에서 얼마나 돈을 지불했는지 알아볼 수 있어요.", pic: "BudgetAll"),
        Board(title: "여행 다이어리", detail: "여행에서 찍은 사진을 다이어리에 저장하고 일기를 써서 나만의 다이어리를 만들어 보세요.", pic: "DiaryAll"),
        Board(title: "국내 여행 정보", detail: "국내 여행, 어디로 가고 싶나요? best 맛집과 관광지를 추천해서 여행 계획을 짜보세요! ", pic: "TravelAll")
    ]
    
    @State var index = 0
    
    var body: some View{
            VStack{
                Image(self.onBoard[self.index].pic)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                
                HStack(spacing: 12){
                    ForEach(0..<self.onBoard.count, id: \.self){ i in
                        Circle()
                            .fill(self.index == i ? Color.gray : Color.black.opacity(0.07))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 30)
                
                Text(self.onBoard[self.index].title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 35)
                
                Text(self.onBoard[self.index].detail)
                    .foregroundColor(.black)
                    .padding(.top)
                    .padding(.horizontal, 20)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    if self.index < self.onBoard.count - 1{
                        self.index += 1
                    }
                    else{
                        // google login
                        handleLogin()
                    }
                }) {
                    // changing Text
                    HStack{
                        if self.index == self.onBoard.count - 1 {
                            HStack{
                                Image("Google")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 25, height:25)
                            }
                        }else{
                        }
                        
                        Text(self.index == self.onBoard.count - 1  ?  "Google Login" : "Next")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 200)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                    .padding(.bottom, 20)
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
            .overlay(
                ZStack{
                    
                    if isLoading{
                        Color.black
                            .opacity(0.25)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .font(.title2)
                            .frame(width: 60, height: 60)
                            .background(Color.white)
                            .cornerRadius(10)
                        }
                }
            )
    }
    
    func handleLogin(){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) { [self]user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
              }

              guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
              else {
                  isLoading = false
                return
              }

              let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { result, err in
                
                isLoading = false
                
                if let error = err {
                    print(error.localizedDescription)
                    return
                  }
                
                guard let user = result?.user else{
                    return 
                }
                
                print(user.displayName ?? "안녕하세요!")
                
             
                // updating user as logged in
                withAnimation{
                    log_Status = true
                }
            }            
        
        }
    }
}

struct Board{
    var title:String
    var detail:String
    var pic:String
}

extension View{
    
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootViewController()->UIViewController{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard  let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
}
