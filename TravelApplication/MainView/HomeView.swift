import SwiftUI
import UIKit

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var index = 0
    @State var show = false
    @Namespace var namespace
    @State var goToViewJeju: Bool = false
    @State var goToViewSeoul: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom, content:{
            NavigationView{
                VStack{
                           ScrollView{
                               LazyVStack(){
                                   // 광고
                                   TabView(selection: self.$index){
                                       ForEach(0...2, id: \.self) { index  in
                                           
                                           Image("AD\(index)")
                                               .resizable()
                                           // add animaition
                                               .frame(height: self.index == index ? 200 : 140)
                                               .cornerRadius(15)
                                               .padding(.horizontal)
                                               .tag(index)
                                       }
                                   }
                                   .frame(height: 200)
                                   .tabViewStyle(PageTabViewStyle())
                                   .animation(.easeOut)
                                   
                                   // 여행 문구..
                                   VStack(alignment: .leading, spacing: 4){
                                       HStack{
                                           Text("     여행비서").bold() + Text("와 함께")
                                       }
                                       HStack{
                                           Text("     여행 떠나 볼까요?")
                                       }
                                       Spacer()
                                       Spacer()
                                       
                                       HStack{
                                           Text("    여행지 추천")
                                               .bold()
                                               .font(.title)
                                       }
                                   }
                                   .padding(.top)
                                   .frame(maxWidth: .infinity, alignment: .leading)
                                   .font(.title3)
                                   .padding(.vertical, 12)
                                   
                                       VStack{
                                          NavigationLink(destination: Jeju(), isActive: $goToViewJeju) {
                                               Button("제주") {
                                                   self.goToViewJeju = true
                                                //self.selection = 1
                                                }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                               
                                               EmptyView()
                                          }
                                          .navigationBarTitle("", displayMode: .automatic)
                                          .navigationBarHidden(true)
                                
                                           HStack{
                                               Button("서울") {
                                                   self.goToViewSeoul = true
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                        
                                               Button("인천") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                           }
                                           
                                           HStack{
                                               Button("경기") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                               
                                               Button("강원") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                           }
                                           
                                           HStack{
                                               Button("충북") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                               
                                               Button("충남/대전") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                           }
                                           
                                           HStack{
                                               Button("부산") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                               
                                               Button("경북/대구") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                           }
                                           
                                           HStack{
                                               Button("전남/광주") {
                                                   
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                               
                                               Button("전북") {
                                               }
                                               .padding(.horizontal)
                                               .buttonStyle(RoundedRectangleButtonStyle())
                                               .buttonStyle(BorderlessButtonStyle())
                                               .buttonStyle(DefaultButtonStyle())
                                           }
                                       }
                                   
                               }
                               .padding(.vertical)
                               .background(Color.white.ignoresSafeArea(.all))
                       }
                    }
                       .padding(.vertical)
                
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
        })
    }
}

struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    Button(action: {}, label: {
      HStack {
        Spacer()
          configuration.label.foregroundColor(.white)
        Spacer()
      }
    })
    .allowsHitTesting(false)
    .padding(15)
    .background(Color.green.opacity(0.8).cornerRadius(10))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            HomeView()
                
        }
    }
}
