import SwiftUI

struct DiaryView: View {
    @StateObject var blogData = BlogViewModel()
    
    // color based on colorscheme..
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        NavigationView{
        VStack(alignment: .center){
            Spacer()
                VStack{
                    Text("여행 일기장")
                        .fontWeight(.heavy)
                        .font(.title)
                }
            if let posts = blogData.posts{
                // no posts..
                if posts.isEmpty{
                    (
                        Text(Image(systemName: "pencil"))
                        +
                        Text("여행에서 겪었던 일을 작성해보세요 :)")
                    )
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    
                }else{
                    List(posts){ post in
                        CardView(post: post)
                        //swipe to delete
                            .swipeActions(edge: .trailing, allowsFullSwipe: true){
                                Button(role: .destructive){
                                    blogData.deletePost(post: post)
                                }label: {
                                    Image(systemName: "trash")
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            else{
                ProgressView()
            }
        }
        .navigationBarHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            //Fab Button
            Button(action :{
                blogData.createPost.toggle()
            }, label : {
                Image(systemName: "pencil")
                    .font(.title2.bold())
                    .foregroundColor(scheme == .dark ? Color.black : Color.white)
                    .padding()
                    .background(.primary, in: Circle())
            })
            .padding()
            .foregroundStyle(.yellow)
            
            ,alignment: .bottomTrailing
        )
        
        // fetching Blog posts...
        .task {
            await blogData.fetchPost()
        }
        .fullScreenCover(isPresented: $blogData.createPost, content: {
            
            // create post view
            CreatePost()
                .overlay(
                    
                    ZStack{
                        
                        Color.primary.opacity(0.25)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .background(scheme == .dark ?.black : .white, in:RoundedRectangle(cornerRadius: 15))
                    }
                        .opacity(blogData.isWriting ? 1 : 0)
                )
                .environmentObject(blogData)
        })
        .alert(blogData.alertMsg, isPresented: $blogData.showAlert){
            
        }
    }
    
    @ViewBuilder
    func CardView(post: Post)->some View{
        // Detail view
        NavigationLink{
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    Text("여행 일정 :  \(post.author)")
                        .foregroundColor(.gray)
                    Text("날짜 :  \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                        .foregroundColor(.gray)
                    
                    ForEach(post.postContent){ content in
                        
                        if content.type == .Image{
                            WebImage(url: content.value)
                        }else{
                            Text(content.value)
                                .font(.system(size: getFontSize(type: content.type)))
                                .lineSpacing(5)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(post.title)
        }label: {
            VStack(alignment: .leading, spacing: 12){
                Text(post.title)
                    .fontWeight(.bold)
                
                Text("여행 일정 날짜 :  \(post.author)")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                
                Text("작성일 :  \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
            }
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
