import SwiftUI

struct CreatePost: View {
    @EnvironmentObject var blogData : BlogViewModel
    
    // post properties..
    @State var postTitle = ""
    @State var authorName = ""
    @State var postContent :[PostContent] = []
    
    // keyboard Focus State for TextView..
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        
        // Since we need Nav Buttin
        NavigationView{
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    
                    VStack(alignment: .leading){
                        TextField("제목", text: $postTitle)
                            .font(.title2)
                        Divider()
                    }
                
                    VStack(alignment: .leading, spacing: 11){
                        Text("날짜: ")
                            .font(.caption.bold())
                        
                        TextField("YY.MM.DD", text: $authorName)
                        
                        Divider()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
                    // post content..
                    ForEach($postContent){ $content in
                        VStack{
                            // Image URL..
                            if content.type == .Image{
                                if content.showImage && content.value != "" {
                                    
                                    WebImage(url: content.value)
                                    // if tab change url
                                        .onTapGesture {
                                            withAnimation{
                                                content.showImage = false
                                            }
                                        }
                                }else{
                                    VStack{
                                        TextField("Image URL", text:$content.value, onCommit: {
                                            withAnimation{
                                                content.showImage = true
                                            }
                                            // To show Image when pressed Return
                                        })
                                        Divider()
                                    }
                                    .padding(.leading,5)
                                }
                                
                            }else{
                                // custom Text Editor from UIKIT..
                                TextView(text: $content.value, height: $content.height, fontSize: getFontSize(type: content.type))
                                    .focused($showKeyboard)
                                // Approx Height Based on Font for First Display..
                                    .frame(height: content.height == 0 ? getFontSize(type: content.type) * 1 : content.height)
                                    .background(
                                        Text(content.type.rawValue)
                                            .font(.system(size : getFontSize(type: content.type)))
                                            .foregroundColor(.gray)
                                            .opacity(content.value == "" ? 0.7 : 0)
                                            .padding(.leading, 5)
                                        
                                        ,alignment: .leading
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity,  maxHeight: .infinity)
                        .contentShape(Rectangle())
                        // swipe to delete..
                        .gesture(DragGesture().onEnded({ value in
                            
                            if -value.translation.width < (UIScreen.main.bounds.width / 2.5) && !content.showDeleteAlert{
                                // showing Alert..content.showDeleteAlert = true
                                content.showDeleteAlert = true
                            }
                        }))
                        .alert("삭제하시겠습니까?", isPresented: $content.showDeleteAlert){
                            
                            Button("삭제", role: .destructive){
                                // Delete content
                                let index = postContent.firstIndex{ currentPost in
                                    return currentPost.id == content.id
                                } ?? 0
                                
                                withAnimation{
                                    postContent.remove(at: index)
                                }
                            }
                        }
                    }
                    
                    // Menu button to insert post content
                    Menu {
                        ForEach(PostType.allCases, id: \.rawValue) { type in
                            Button(type.rawValue){
                                // appending new post content
                                withAnimation{
                                    postContent.append(PostContent(value: "", type : type))
                                }
                            }
                        }
                    }label :{
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                    .foregroundStyle(.yellow)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            })
            // changing post title dynamic
            .navigationTitle(postTitle == "" ?  "제목 " : postTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        if !showKeyboard{
                            Button("X"){
                                blogData.createPost.toggle()
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        if showKeyboard{
                            Button("완료"){
                                // Closing keyboard
                                showKeyboard.toggle()
                            }
                        }
                        else{
                            Button("저장"){
                                blogData.writePost(content: postContent, author: authorName, postTitle: postTitle)
                            }
                            .disabled(authorName == "" || postTitle == "")
                        }
                    }
                }
        }
    }
}

struct CreatePost_Previews: PreviewProvider {
    static var previews: some View {
        CreatePost()
    }
}

// Dynamic height
func getFontSize(type: PostType)->CGFloat{
    
    // Your own..
    switch type{
    case .Header:
        return 24
    case .SubHeading:
    return 22
    case .Paragraph:
        return 18
    case.Image:
        return 18
    }
}

// ASync Image
struct WebImage: View{
    
    var url:String
    
    var body: some View{
        
        AsyncImage(url: URL(string: url)) { phase in
            
            if let image = phase.image{
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                    .cornerRadius(15)
            }else{
                
                if let _ = phase.error{
                    Text("이미지를 업로드하는데 실패하셨습니다. 다시 시도해주세요 : (((")
                }else{
                    ProgressView()
                }
            }
        }
        .frame(height: 250)
    }
}
