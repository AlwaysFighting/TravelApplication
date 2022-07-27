import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab:String
    
    // store
    @State var tabPoints:[CGFloat] = []
    
    var body: some View {
        
        HStack(spacing : 0){
            
            TabBarButton(image: "house", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "creditcard", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "calendar.badge.clock", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "square.and.pencil", selectedTab: $selectedTab, tabPoints: $tabPoints)
            
            TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(Color.indigo
            .clipShape(TabCurve(tabPoints : ))
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    func getCurve
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct TabBarButton:View{
    
    var image:String
    @Binding var selectedTab:String
    @Binding var tabPoints:[CGFloat]
    
    var body: some View{
        GeometryReader{ reader -> AnyView in
            
            // extracting
            let midX = reader.frame(in: .global).midX
            
            DispatchQueue.main.async {
                if tabPoints.count <= 5{
                    tabPoints.append(midX)
                }
            }
            return AnyView{
                Button(action: {
                    withAnimation{
                       selectedTab = image
                    }
                }, label :{
                    
                    Image(systemName: image)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color.white)
                        .offset(y: selectedTab == image ? -10 : 0)
                    
                })
                .frame(maxWidth:.infinity, maxHeight: .infinity)
            }
        }
        .frame(height: 50)
        
    }
}
