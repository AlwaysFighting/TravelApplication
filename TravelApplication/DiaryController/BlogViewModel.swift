import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class BlogViewModel:ObservableObject{
    // Post..
    @Published var posts: [Post]?
    // errors
    @Published var alertMsg = ""
    @Published var showAlert = false
    
    // New post..
    @Published var createPost = false
    @Published var isWriting = false
    
    // Async Await
    func fetchPost() async{
        
        do{
            let db = Firestore.firestore().collection("Blog")
            
            let posts = try await db.getDocuments()
            
            // Converting to out Model
            self.posts = posts.documents.compactMap({ post in
                
                return try? post.data(as: Post.self)
            })
            
        }catch{
            alertMsg = error.localizedDescription
            showAlert.toggle()
        }
        
    }
    
    func deletePost(post: Post){
        
        guard let _ = posts else{return}
        
        let index = posts?.firstIndex(where: { currentPost in
            return currentPost.id == post.id
        }) ?? 0
        
        // deleting post..
        Firestore.firestore().collection("Blog").document(post.id ?? "").delete()
        
        withAnimation{ posts?.remove(at: index)}
    }
    
    func writePost(content: [PostContent], author: String, postTitle: String){
        do{
            // loading animation..
            withAnimation{
                isWriting = true
            }
    
            let post  = Post(title: postTitle, author: author, postContent: content, date: Timestamp(date: Date()))
            // storing to DB
            let _ = try Firestore.firestore().collection("Blog").document().setData(from: post)
            
            withAnimation{
                // add to post
                posts?.append(post)
                isWriting = true
                // closing post view..
                createPost = false
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
}
