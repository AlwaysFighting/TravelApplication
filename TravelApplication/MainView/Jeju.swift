import SwiftUI

struct Jeju: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    @State var selected : Card = data[0]
    @State var show = false
    @State var show2 = false
    @Namespace var namespace
    @State var loadView = false  // to load view after animation
    
    var body: some View {
        NavigationView{
            ZStack{
                    ScrollView{
                        HStack(alignment: .top){
                            Text("  제주도 추천 여행지")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                        }
                        .padding([.horizontal, .top])
                        
                        LazyVGrid(columns: columns, spacing: 25){
                            ForEach(data){ travel in
                                VStack(alignment: .leading, spacing: 10){
                                    Image(travel.image)
                                        .resizable()
                                        .frame(height: 180)
                                        .cornerRadius(15)
                                    // assigning ID
                                        .onTapGesture {
                                            withAnimation(.spring()){
                                                if travel.id == 4{
                                                    show.toggle()
                                                    selected = travel
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                                        loadView.toggle()
                                                    }
                                                }else if travel.id == 0{
                                                    show2.toggle()
                                                    selected = travel
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                                                        loadView.toggle()
                                                    }
                                                }
                                            }
                                        }
                                        .matchedGeometryEffect(id: travel.id, in: namespace)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                
                if show{
                    
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                            Image(selected.image)
                                .resizable()
                                .padding(-25)
                                .frame(height: 200)
                                .matchedGeometryEffect(id: selected.image, in: namespace)
                            
                            if loadView{
                                HStack{
                                    Button{
                                        loadView.toggle()
                                        
                                        withAnimation(.spring()){
                                            show.toggle()
                                        }
                                    }label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                    
                                    Spacer()
                                    
                                    Button{
                                        withAnimation(.spring()){
                                            show.toggle()
                                        }
                                    }label: {
                                        Image(systemName: "bookmark")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.top, 10)
                                .padding(.horizontal)
                            }
                        }
                        .navigationBarHidden(true)
                        
                        // Detail view
                        ScrollView(.vertical, showsIndicators: false){
                            
                            // loading after animation complete
                            if loadView{
                                
                                // extra argument in call -> group 사용!
                                VStack{
                                    
                                    // 정보
                                    Group{
                                        HStack{
                                            Text("장소 정보")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 20)
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        Text("서귀포는 다른 지역에 비해 용천수가 많이 솟고, 지하 층에 물이 잘 스며들지 않는 수성응회암이 널리 분포하여 다른 지역보다 상대적으로 폭포가 많다. 그런 서귀포 폭포 중에서도 규모나 경관 면에서 단연 으뜸으로 관광객의 발길이 머무는 곳이 있으니, 천지연 폭포가 바로 그곳이다.")
                                            .multilineTextAlignment(.leading)
                                            .padding(.top)
                                            .padding(.horizontal)
                                            .foregroundColor(.gray)
                                        
                                        HStack{
                                            Text("주소")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 20)
                                        .padding(.horizontal)
                                                                      
                                        HStack{
                                            Text("제주 서귀포시 천지동 667-7")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("영업시간")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 3)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("매일 09:00 - 22:00 입장마감 21:20")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("전화번호")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 3)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("064-733-1528")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack(spacing : 15){
                                            Text("추천 맛집")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)
                                    }
                                    
                                    // 사진
                                    Group{
                                        TabView{
                                            ForEach(0...2, id: \.self) { index  in
                                                Image("r\(index)")
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .padding(.horizontal)
                                            }
                                        }
                                        .frame(height: 200)
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .padding(.top)
                                        
                                        Spacer()
                                        
                                        HStack(spacing : 10){
                                            Text("천지연 폭포 관련 이미지")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)

                                        TabView{
                                            ForEach(1...4, id: \.self) { index  in
                                                Image("ch\(index)")
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .padding(.horizontal)
                                            }
                                        }
                                        .frame(height: 200)
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .padding(.top)
                                    }
                                    
                                }
                                .padding(.top, 10)
                                .padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                }
                
                if show2{
                    
                    VStack{
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                            Image(selected.image)
                                .resizable()
                                .padding(-25)
                                .frame(height: 200)
                                .matchedGeometryEffect(id: selected.image, in: namespace)
                            
                            if loadView{
                                HStack{
                                    Button{
                                        loadView.toggle()
                                        
                                        withAnimation(.spring()){
                                            show2.toggle()
                                        }
                                    }label: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                    
                                    Spacer()
                                    
                                    Button{
                                        withAnimation(.spring()){
                                            show2.toggle()
                                        }
                                    }label: {
                                        Image(systemName: "bookmark")
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black.opacity(0.5))
                                            .clipShape(Circle())
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.horizontal)
                            }
                        }
                        
                        // Detail view
                        ScrollView(.vertical, showsIndicators: false){
                            
                            // loading after animation complete
                            if loadView{
                                
                                // extra argument in call -> group 사용!
                                VStack{
                                    
                                    // 정보
                                    Group{
                                        HStack{
                                            Text("장소 정보")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 20)
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        Text("테디베어뮤지엄은 1902년에 탄생한 테디베어의 역사를 전시한 국내 최초이자 최대 규모의 박문관이다. 세계 각국에서 모아 온 진귀한 테디베어들이 전시되어있을 뿐만 아니라, 테디베이어 전시를 통해서 20세기 인류 역사를 소개하고 있다. 엘비스 프레실리의 유명 히트공연을 감상할 수도 있고, 세계적인 명화를 패러디한 베어 등 흥미롭고 다채로운 구성으로 누구나 좋아하고 사랑하는 테디베어를 만날 수 있다.")
                                            .multilineTextAlignment(.leading)
                                            .padding(.top)
                                            .padding(.horizontal)
                                            .foregroundColor(.gray)
                                        
                                        HStack{
                                            Text("주소")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 20)
                                        .padding(.horizontal)
                                                                      
                                        HStack{
                                            Text("제주 특별 자치도 서귀포시 색달동 2889")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("영업시간")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 3)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("매일 오전 9:00 ~ 오후 6:00")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("전화번호")
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                
                                            Spacer()
                                        }
                                        .padding(.top, 3)
                                        .padding(.horizontal)
                                        
                                        HStack{
                                            Text("064-738-7600")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black.opacity(0.6))
                                
                                            Spacer()
                                        }
                                        .padding(.top, 0.2)
                                        .padding(.horizontal)
                                        
                                        HStack(spacing : 10){
                                            Text("입장권")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)
                                    }
                                    
                                    // 사진
                                    Group{
                                        HStack(spacing : 3){
                                            Text("티켓 최저가: ₩7,000")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .foregroundColor(.cyan)
                                            Spacer()
                                        }
                                        .padding(.top, 3)
                                        .padding(.horizontal)
                                        
                                        HStack(spacing : 15){
                                            Text("추천 맛집")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)
                                        
                                        TabView{
                                            ForEach(1...2, id: \.self) { index  in
                                                Image("t\(index)")
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .padding(.horizontal)
                                            }
                                        }
                                        .frame(height: 200)
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .padding(.top)
                                        
                                        Spacer()
                                        
                                        HStack(spacing : 10){
                                            Text("테디베어 박물관 관련 이미지")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                            Spacer()
                                        }
                                        .padding(.top)
                                        .padding(.horizontal)

                                        TabView{
                                            ForEach(1...2, id: \.self) { index  in
                                                Image("te\(index)")
                                                    .resizable()
                                                    .cornerRadius(15)
                                                    .padding(.horizontal)
                                            }
                                        }
                                        .frame(height: 200)
                                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                        .padding(.top)
                                    }
                                    
                                }
                                .padding(.top, 20)
                            }
                        }
                    }
                    .background(Color.white)
                }
            }.background(Color.white.edgesIgnoringSafeArea(.all))
                .navigationBarHidden(true)
               // .statusBar(hidden: show ? true : false) // hiding for view
            
        }
        .padding(.top, -100)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Jeju_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Jeju()
                .edgesIgnoringSafeArea(.top)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Card:Identifiable{
    var id : Int
    var image:String
    var title:String
}

var data = [
    Card(id:0, image: "Jeju1", title: "테디베어 박물관"),
    Card(id:1, image: "Jeju2", title: "제주 용암동굴"),
    Card(id:2, image: "Jeju3", title: "제주 동백 수목원"),
    Card(id:3, image: "Jeju4", title: "오셜록 티 뮤지엄"),
    Card(id:4, image: "Jeju5", title: "천지연 폭포")
]




